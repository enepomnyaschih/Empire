window.Api = window.Api || {};

Api.baseUrl = window.location.protocol + "//" + window.location.hostname + "/";

apply(Api, {
    getMemberInfo       : Api.baseUrl + "GetMemberInfo",
    login               : Api.baseUrl + "Login",
    logout              : Api.baseUrl + "Logoff",
    register            : Api.baseUrl + "Register"
});
