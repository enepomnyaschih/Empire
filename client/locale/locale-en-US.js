window.Locale = window.Locale || {};

apply(Locale, {
    authorization               : "Authorization",
    back                        : "Back",
    confirm                     : "Confirm",
    login                       : "Login",
    password                    : "Password",
    register                    : "Register",
    registration                : "Registration",
    remember                    : "Remember",
    rememberTip                 : "If you'll check this option, then you'll be logged in until manual logging off. In other case, the session will be interrupted after 30 minutes of inactivity automatically.",
    start                       : "Start",
    startTip                    : "Check this option to login right after registration.",
    useCookie                   : "Use cookie",
    useCookieTip                : "If you'll check this option, then the session will not interrupt by page refreshing. But you'll can not use different browser tabs to login as different users.",
    
    errors: {
        ERROR_MEMBER_ID_TOO_SHORT   : "Login must contain at least 2 symbols.",
        ERROR_MEMBER_ID_BUSY        : "Login you entered is busy already. Choose another one.",
        ERROR_PASSWORD_TOO_SHORT    : "Password must contain at least 6 symbols.",
        ERROR_PASSWORDS_DIFFERENT   : "Password fields values are different. Try again."
    }
});
