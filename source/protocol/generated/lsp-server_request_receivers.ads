--  Automatically generated, do not edit.

limited with LSP.Messages.Server_Requests;

package LSP.Server_Request_Receivers is

   type Server_Request_Receiver is limited interface;

   procedure On_Initialize_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Initialize_Request)
        is abstract;

   procedure On_Shutdown_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Shutdown_Request)
        is abstract;

   procedure On_CodeAction_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.CodeAction_Request)
        is abstract;

   procedure On_Completion_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Completion_Request)
        is abstract;

   procedure On_Definition_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Definition_Request)
        is abstract;

   procedure On_Type_Definition_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Type_Definition_Request)
        is abstract;

   procedure On_Highlight_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Highlight_Request)
        is abstract;

   procedure On_Hover_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Hover_Request)
        is abstract;

   procedure On_References_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.References_Request)
        is abstract;

   procedure On_Signature_Help_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Signature_Help_Request)
        is abstract;

   procedure On_Document_Symbols_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Document_Symbols_Request)
        is abstract;

   procedure On_Rename_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Rename_Request)
        is abstract;

   procedure On_Execute_Command_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Execute_Command_Request)
        is abstract;

   procedure On_Workspace_Symbols_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Workspace_Symbols_Request)
        is abstract;

   procedure On_Workspace_Execute_Command_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.Workspace_Execute_Command_Request)
        is abstract;

   procedure On_ALS_Called_By_Request
     (Self  : access Server_Request_Receiver;
      Value : LSP.Messages.Server_Requests.ALS_Called_By_Request)
        is abstract;

end LSP.Server_Request_Receivers;
