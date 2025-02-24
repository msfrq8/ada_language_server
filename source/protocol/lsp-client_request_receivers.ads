------------------------------------------------------------------------------
--                         Language Server Protocol                         --
--                                                                          --
--                     Copyright (C) 2019, AdaCore                          --
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
--  Interface to process request sent to the client.

limited with LSP.Messages.Client_Requests;

package LSP.Client_Request_Receivers is

   type Client_Request_Receiver is limited interface;
   --  Receiver of request on LSP client side

   procedure On_ShowMessage_Request
     (Self    : access Client_Request_Receiver;
      Message : LSP.Messages.Client_Requests.ShowMessage_Request) is abstract;

   procedure On_Workspace_Apply_Edit_Request
     (Self    : access Client_Request_Receiver;
      Message : LSP.Messages.Client_Requests.Workspace_Apply_Edit_Request)
        is abstract;

end LSP.Client_Request_Receivers;
