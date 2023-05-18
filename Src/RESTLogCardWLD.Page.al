page 79910 "REST Log Card WLD"
{
    Caption = 'REST Log';
    Editable = false;
    PageType = Card;
    SourceTable = "REST Log WLD";
    layout
    {
        area(Content)
        {
            group(General)
            {
                field(RequestMethod; Rec.RequestMethod)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RequestMethod';
                }
                field(RequestUrl; Rec.RequestUrl)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RequestUrl';
                }
                field(ContentType; Rec.ContentType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ContentType';
                }
                field(DateTimeCreated; Rec.DateTimeCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the DateTimeCreated';
                }
                field(Duraction; Rec.Duraction)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Duraction';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User';
                }
            }
            group(Request)
            {
                field(RequestBodySize; Rec.RequestBodySize)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RequestBodySize';
                }
                field(RequestHeaders; Rec.RequestHeaders)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the RequestHeaders';
                }
            }
            group(Response)
            {
                field(ResponseHttpStatusCode; Rec.ResponseHttpStatusCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ResponseHttpStatusCode';
                }
                field(ResponseSize; Rec.ResponseSize)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ResponseSize';
                }
            }
        }
    }
}
