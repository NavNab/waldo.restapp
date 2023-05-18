codeunit 79910 "JSONHelper WLD"
{
    Access = Public;

    var
        TokenKeyErr: Label 'Could not find a token with key %1', Comment = '%1 = Error';
        TokenPathErr: Label 'Could not find a token with path %1', Comment = '%1 = Error';
        JsonObjectVar: JsonObject;

    procedure GetJsonObject(): JsonObject
    begin
        exit(JsonObjectVar);
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: Text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error(TokenKeyErr, TokenKey);
    end;

    procedure GetJsonToken(TokenKey: Text) JsonToken: JsonToken
    begin
        if not JsonObjectVar.Get(TokenKey, JsonToken) then
            Error(TokenKeyErr, TokenKey);
    end;

    procedure GetJsonTokenAsValue(JsonObject: JsonObject; TokenKey: Text) JsonValue: JsonValue
    var
        JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error(TokenKeyErr, TokenKey);
        JsonValue := JsonToken.AsValue();
    end;

    procedure InitializeJsonObjectFromText(JSONText: Text)
    var
        InvalidJsonTextErr: Label 'Invalid JSON Text \ %1', Comment = '%1 = Text value';
    begin
        if not JsonObjectVar.ReadFrom(JSONText) then
            Error(InvalidJsonTextErr, JSONText);
    end;

    procedure InitializeJsonObjectFromToken(Token: JsonToken)
    begin
        JsonObjectVar := Token.AsObject();
    end;

    procedure SelectJsonToken(Path: Text) JsonToken: JsonToken
    begin
        if not JsonObjectVar.SelectToken(Path, JsonToken) then
            Error(TokenPathErr, Path);
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: Text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error(TokenPathErr, Path);
    end;

    procedure SetValue("Key": Text; "Value": Text)
    begin
        if JsonObjectVar.Contains("Key") then
            JsonObjectVar.Replace("Key", "Value")
        else
            JsonObjectVar.Add("Key", "Value");
    end;
}