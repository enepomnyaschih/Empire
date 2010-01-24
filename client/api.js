window.Api = window.Api || {};

Api.baseUrl = window.location.protocol + "//" + window.location.hostname + "/";

apply(Api, {
    login               : Api.baseUrl + "login"
});
