


var IsNullOrEmpty = (function (p) {
    switch (p) {
        case "":
        case 0:
        case "0":
        case '':
        case null:
        case false:
        case typeof this == "undefined":
        case undefined:
            return true;
        default:
            return false;
    }
});