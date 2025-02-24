------------------------------------------------------------------------------
--                         Language Server Protocol                         --
--                                                                          --
--                     Copyright (C) 2018-2019, AdaCore                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
------------------------------------------------------------------------------
--
--  This package provides a basic LSP server implementation.
--
--  The Server object is initializad with Request and Notification handlers,
--  that actually implements message processing.

with Ada.Streams;

with LSP.Client_Notification_Receivers;
with LSP.Message_Loggers;
with LSP.Messages;
with LSP.Server_Request_Handlers;
with LSP.Server_Notification_Receivers;
with LSP.Types;

with GNATCOLL.Traces;

private with Ada.Strings.Unbounded;
private with Ada.Containers.Synchronized_Queue_Interfaces;
private with Ada.Containers.Unbounded_Synchronized_Queues;
private with GNAT.Semaphores;
private with System;

package LSP.Servers is

   type Server is limited
     new LSP.Client_Notification_Receivers.Client_Notification_Receiver
       with private;
   --  The representation of LSP server.
   --  Use methods of Client_Notification_Receiver to send notifications to
   --  LSP client.

   procedure Initialize
     (Self   : in out Server;
      Stream : access Ada.Streams.Root_Stream_Type'Class);
   --  Initialize a server by providing input/output Stream.

   procedure Finalize (Self : in out Server);
   --  Clean up memory, file handles, tasks, etc.

   procedure Run
     (Self         : in out Server;
      Request      : not null
        LSP.Server_Request_Handlers.Server_Request_Handler_Access;
      Notification : not null
        LSP.Server_Notification_Receivers.Server_Notification_Receiver_Access;
      Server_Trace : GNATCOLL.Traces.Trace_Handle;
      In_Trace     : GNATCOLL.Traces.Trace_Handle;
      Out_Trace    : GNATCOLL.Traces.Trace_Handle);
   --  Run the server using given Request and Notification handler.
   --  Server_Trace - main trace for the LSP.
   --  In_Trace and Out_Trace - traces that logs all input & output for
   --  debugging purposes.

   procedure Stop (Self : in out Server);
   --  Ask server to stop

private

   -------------------------
   --  Tasking in the ALS --
   -------------------------

   --  The server has 3 tasks:
   --    The input task
   --         This reads input coming from stdin, forms requests, and places
   --         them on the requests queue.
   --    The processing task:
   --         This is the task where libadalang lives. This task receives
   --         requests from the request queue, processes them, and returns
   --         the responses from them on the output queue.
   --    The output task:
   --         This task reads the responses coming from the output queue,
   --         and writes them to the standard output.

   type Stream_Access is access all Ada.Streams.Root_Stream_Type'Class;

   type Message_Access is access all LSP.Messages.Message'Class;
   --  There are two flows of messages:
   --  * Message created byt Input_Tast and destroyed by Processing_Task.
   --  * Message created by Processing_Task and destroyed by Output_Task.

   package Message_Queue_Interface is new
     Ada.Containers.Synchronized_Queue_Interfaces
       (Message_Access);

   package Unbounded_String_Queue_Interface is new
     Ada.Containers.Synchronized_Queue_Interfaces
       (Ada.Strings.Unbounded.Unbounded_String);
   package Input_Queues is new
     Ada.Containers.Unbounded_Synchronized_Queues
       (Message_Queue_Interface);
   package Output_Queues is new
     Ada.Containers.Unbounded_Synchronized_Queues
       (Message_Queue_Interface);

   type Input_Queue_Access is access Input_Queues.Queue;
   type Output_Queue_Access is access Output_Queues.Queue;

   --  The processing task
   task type Processing_Task_Type
     (Server : access LSP.Servers.Server)
   is
      entry Start
        (Request      : not null LSP.Server_Request_Handlers
           .Server_Request_Handler_Access;
         Notification : not null LSP.Server_Notification_Receivers
           .Server_Notification_Receiver_Access);
      entry Stop;
      --  Clean shutdown of the task
   end Processing_Task_Type;

   --  The output task
   task type Output_Task_Type
     (Server : access LSP.Servers.Server)
   is
      entry Start;
      --  Start the task. Should be called once.

      entry Stop;
      --  Clean shutdown of the task. Can only be called after Start.
   end Output_Task_Type;

   --  The input task
   task type Input_Task_Type
     (Server : access LSP.Servers.Server)
   is
      entry Start;
      --  Start the task. Should be called once.

      entry Stop;
      --  Clean shutdown of the task. Can only be called after Start.
   end Input_Task_Type;

   type Server is limited
     new LSP.Client_Notification_Receivers.Client_Notification_Receiver with
   record
      Stop          : GNAT.Semaphores.Binary_Semaphore
                          (Initially_Available => False,
                           Ceiling => System.Default_Priority);
      --  Signal to main task to stop server. Released on "exit" message or
      --  on end of input stream.
      Stream        : access Ada.Streams.Root_Stream_Type'Class;
      Last_Request  : LSP.Types.LSP_Number := 1;
      Vector        : Ada.Strings.Unbounded.Unbounded_String;

      --  Queues and tasks used for asynchronous processing, see doc above
      Input_Queue     : Input_Queues.Queue;
      Output_Queue    : Output_Queues.Queue;
      Processing_Task : Processing_Task_Type (Server'Unchecked_Access);
      Output_Task     : Output_Task_Type (Server'Unchecked_Access);
      Input_Task      : Input_Task_Type (Server'Unchecked_Access);

      Server_Trace    : GNATCOLL.Traces.Trace_Handle;
      In_Trace        : GNATCOLL.Traces.Trace_Handle;
      Out_Trace       : GNATCOLL.Traces.Trace_Handle;
      Logger          : aliased LSP.Message_Loggers.Message_Logger;
   end record;

   overriding procedure On_Show_Message
     (Self   : access Server;
      Params : LSP.Messages.ShowMessageParams);

   overriding procedure On_Log_Message
     (Self   : access Server;
      Params : LSP.Messages.LogMessageParams);

   overriding procedure On_Publish_Diagnostics
     (Self   : access Server;
      Params : LSP.Messages.PublishDiagnosticsParams);

end LSP.Servers;
