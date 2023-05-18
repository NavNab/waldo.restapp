codeunit 79911 "REST Helper WLD"
{
    Access = Public;
    //TODO: Build in RequestCatcher.com functionality so that it's easy to analyze requests that come from Business Central
    var
        ContentTypeSet: Boolean;
        WebClient: HttpClient;
        WebContent: HttpContent;
        WebContentHeaders: HttpHeaders;
        WebRequestHeaders: HttpHeaders;
        WebRequest: HttpRequestMessage;
        WebResponse: HttpResponseMessage;
        CurrentContentType: Text;
        RestHeaders: TextBuilder;

    procedure AddBody(Body: Text)
    begin
        WebContent.WriteFrom(Body);
        ContentTypeSet := true;
    end;

    procedure AddRequestHeader(HeaderKey: Text; HeaderValue: Text)
    begin
        RestHeaders.AppendLine(HeaderKey + ': ' + HeaderValue);
        WebRequestHeaders.Add(HeaderKey, HeaderValue);
    end;

    procedure GetHttpStatusCode(): Integer
    begin
        exit(WebResponse.HttpStatusCode());
    end;

    procedure GetResponseContentAsText() ResponseContentText: Text
    var
        RestBlob: Codeunit "Temp Blob";
        Instr: InStream;
    begin
        RestBlob.CreateInStream(Instr);
        WebResponse.Content().ReadAs(ResponseContentText);
    end;

    procedure GetResponseReasonPhrase(): Text
    begin
        exit(WebResponse.ReasonPhrase());
    end;

    procedure Initialize(Method: Text; URI: Text);
    begin
        WebRequest.Method := Method;
        WebRequest.SetRequestUri(URI);
        WebRequest.GetHeaders(WebRequestHeaders);
    end;

    procedure Send() SendSuccess: Boolean
    var
        StartDateTime: DateTime;
        TotalDuration: Duration;
    begin
        if ContentTypeSet then
            WebRequest.Content(WebContent);
        OnBeforeSend(WebRequest, WebResponse);
        StartDateTime := CurrentDateTime();
        SendSuccess := WebClient.Send(WebRequest, WebResponse);
        TotalDuration := CurrentDateTime() - StartDateTime;
        OnAfterSend(WebRequest, WebResponse);
        if SendSuccess then
            if not WebResponse.IsSuccessStatusCode() then
                SendSuccess := false;
        Log(StartDateTime, TotalDuration);
    end;

    procedure SetContentType(ContentType: Text)
    begin
        CurrentContentType := ContentType;
        WebContent.GetHeaders(WebContentHeaders);
        if WebContentHeaders.Contains('Content-Type') then
            WebContentHeaders.Remove('Content-Type');
        WebContentHeaders.Add('Content-Type', ContentType);
    end;

    local procedure Log(StartDateTime: DateTime; TotalDuration: Duration)
    var
        RESTLog: Record "REST Log WLD";
        ResponseBlob: Codeunit "Temp Blob";
        RestBlob: Codeunit "Temp Blob";
        Instr: InStream;
        ResponseInstr: InStream;
        Outstr: OutStream;
    begin
        RestBlob.CreateInStream(Instr);
        WebContent.ReadAs(Instr);
        ResponseBlob.CreateInStream(ResponseInstr);
        WebResponse.Content().ReadAs(ResponseInstr);
        RESTLog.Init();
        RESTLog.RequestUrl := CopyStr(WebRequest.GetRequestUri(), 1, MaxStrLen(RESTLog.RequestUrl));
        RESTLog.RequestMethod := CopyStr(WebRequest.Method(), 1, MaxStrLen(RESTLog.RequestMethod));
        RESTLog.RequestBody.CreateOutStream(Outstr);
        CopyStream(Outstr, Instr);
        RESTLog.RequestBodySize := RESTLog.RequestBody.Length();
        RESTLog.ContentType := CopyStr(CurrentContentType, 1, MaxStrLen(RESTLog.ContentType));
        RESTLog.RequestHeaders := CopyStr(RestHeaders.ToText(), 1, MaxStrLen(RESTLog.RequestHeaders));
        RESTLog.ResponseHttpStatusCode := GetHttpStatusCode();
        RESTLog.Response.CreateOutStream(Outstr);
        CopyStream(Outstr, ResponseInstr);
        RESTLog.ResponseSize := RESTLog.Response.Length();
        RESTLog.DateTimeCreated := StartDateTime;
        RESTLog.User := CopyStr(UserId(), 1, MaxStrLen(RESTLog.User));
        RESTLog.Duraction := TotalDuration;
        RESTLog.Insert();
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSend(WebRequest: HttpRequestMessage; WebResponse: HttpResponseMessage)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeSend(WebRequest: HttpRequestMessage; WebResponse: HttpResponseMessage)
    begin
    end;
}