permissionset 79910 "RESTApp WLD"
{
    Assignable = true;
    Permissions = table "REST Log WLD" = X,
        tabledata "REST Log WLD" = RIMD,
        codeunit "JSONHelper WLD" = X,
        codeunit "REST Helper WLD" = X,
        codeunit "ShowRequestMessage Meth WLD" = X,
        codeunit "ShowResponseMessage Meth WLD" = X,
        page "REST Log Card WLD" = X,
        page "REST Log List WLD" = X;
}