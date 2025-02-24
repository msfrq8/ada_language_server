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

with LSP.Generic_Responses;
with LSP.Server_Response_Senders; use LSP.Server_Response_Senders;

package LSP.Messages.Server_Responses is

   type Server_Response is abstract new ResponseMessage with null record;

   procedure Visit
     (Self    : Server_Response;
      Handler : access Server_Response_Sender'Class) is abstract;

   package Initialize_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => InitializeResult);

   type Initialize_Response is new Initialize_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : Initialize_Response;
      Handler : access Server_Response_Sender'Class);

   package Completion_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => CompletionList);

   type Completion_Response is new Completion_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : Completion_Response;
      Handler : access Server_Response_Sender'Class);

   package Hover_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => Hover);

   type Hover_Response is new Hover_Responses.Response with null record;

   overriding procedure Visit
     (Self    : Hover_Response;
      Handler : access Server_Response_Sender'Class);

   package SignatureHelp_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => SignatureHelp);

   type SignatureHelp_Response is new SignatureHelp_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : SignatureHelp_Response;
      Handler : access Server_Response_Sender'Class);

   package Highlight_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => DocumentHighlight_Vector);

   type Highlight_Response is new Highlight_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : Highlight_Response;
      Handler : access Server_Response_Sender'Class);

   package Symbol_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => SymbolInformation_Vector);

   type Symbol_Response is new Symbol_Responses.Response with null record;

   overriding procedure Visit
     (Self    : Symbol_Response;
      Handler : access Server_Response_Sender'Class);

   package Rename_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => WorkspaceEdit);

   type Rename_Response is new Rename_Responses.Response with null record;

   overriding procedure Visit
     (Self    : Rename_Response;
      Handler : access Server_Response_Sender'Class);

   package CodeAction_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => Command_Vector);

   type CodeAction_Response is new CodeAction_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : CodeAction_Response;
      Handler : access Server_Response_Sender'Class);

   package Location_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => Location_Vector);

   type Location_Response is new Location_Responses.Response with null record;

   overriding procedure Visit
     (Self    : Location_Response;
      Handler : access Server_Response_Sender'Class);

   package ALS_Called_By_Responses is new LSP.Generic_Responses
     (ResponseMessage => Server_Response,
      T               => ALS_Subprogram_And_References_Vector);

   type ALS_Called_By_Response is new ALS_Called_By_Responses.Response with
     null record;

   overriding procedure Visit
     (Self    : ALS_Called_By_Response;
      Handler : access Server_Response_Sender'Class);

   type ExecuteCommand_Response is new Server_Response with null record;

   overriding procedure Visit
     (Self    : ExecuteCommand_Response;
      Handler : access Server_Response_Sender'Class);

   type Shutdown_Response is new Server_Response with null record;

   overriding procedure Visit
     (Self    : Shutdown_Response;
      Handler : access Server_Response_Sender'Class);

end LSP.Messages.Server_Responses;
