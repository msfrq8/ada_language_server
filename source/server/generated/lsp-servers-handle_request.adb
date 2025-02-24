--  Automatically generated, do not edit.

with LSP.Messages.Server_Requests; use LSP.Messages.Server_Requests;
with Ada.Strings.UTF_Encoding;

function LSP.Servers.Handle_Request
  (Self    : not null Server_Request_Handlers
     .Server_Request_Handler_Access;
   Request : LSP.Messages.RequestMessage'Class)
      return LSP.Messages.ResponseMessage'Class
is
   function "+" (Text : Ada.Strings.UTF_Encoding.UTF_8_String)
     return LSP.Types.LSP_String renames LSP.Types.To_LSP_String;
begin

      if Request in Initialize_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Initialize_Request
                  (Initialize_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Shutdown_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Shutdown_Request;
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in CodeAction_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_CodeAction_Request
                  (CodeAction_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Completion_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Completion_Request
                  (Completion_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Definition_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Definition_Request
                  (Definition_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Type_Definition_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Type_Definition_Request
                  (Type_Definition_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Highlight_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Highlight_Request
                  (Highlight_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Hover_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Hover_Request
                  (Hover_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in References_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_References_Request
                  (References_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Signature_Help_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Signature_Help_Request
                  (Signature_Help_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Document_Symbols_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Document_Symbols_Request
                  (Document_Symbols_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Rename_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Rename_Request
                  (Rename_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Execute_Command_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Execute_Command_Request
                  (Execute_Command_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Workspace_Symbols_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Workspace_Symbols_Request
                  (Workspace_Symbols_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in Workspace_Execute_Command_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_Workspace_Execute_Command_Request
                  (Workspace_Execute_Command_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

      if Request in ALS_Called_By_Request'Class then
         declare
            R : LSP.Messages.ResponseMessage'Class :=
               Self.On_ALS_Called_By_Request
                  (ALS_Called_By_Request (Request).params);
         begin
            R.jsonrpc := +"2.0";
            R.id := Request.id;
            return R;
         end;
      end if;

   return LSP.Messages.ResponseMessage'
     (Is_Error => True,
      jsonrpc  => <>,
      id       => <>,
      error    =>
        (Is_Set => True,
         Value  =>
           (code    => LSP.Messages.MethodNotFound,
            message => +"The Request handler doesn't support this",
            others  => <>)));
end LSP.Servers.Handle_Request;
