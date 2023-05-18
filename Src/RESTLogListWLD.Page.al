page 79911 "REST Log List WLD"
{
    ApplicationArea = All;
    Caption = 'REST Log List';
    CardPageId = "REST Log Card WLD";
    PageType = List;
    SourceTable = "REST Log WLD";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Entry No.';
                }
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
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User';
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(ShowRequestMessage)
            {
                ApplicationArea = All;
                Caption = 'Show Request Message';
                Image = ShowSelected;
                Scope = "Repeater";
                ToolTip = 'Shows the request message';
                trigger OnAction()
                begin
                    Rec.ShowRequestMessage();
                end;
            }
            action(ShowResponseMessage)
            {
                ApplicationArea = All;
                Caption = 'Show Response Message';
                Image = ShowSelected;
                Scope = "Repeater";
                ToolTip = 'Shows the response message';
                trigger OnAction()
                begin
                    Rec.ShowResponseMessage();
                end;
            }
        }
    }
}
