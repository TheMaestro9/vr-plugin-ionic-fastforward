/*global cordova, module*/

vrview = {
    TYPE_MONO: 1,
    TYPE_STEREO_OVER_UNDER: 2,
    FORMAT_DEFAULT: 1,
    FORMAT_HLS: 2,
    FORMAT_DASH: 3,
    playVideo: function (videoUrl, inputType, inputFormat) {
        var inputTypeValue = vrview.getTypeFromString(inputType);
        var inputFormatValue = vrview.getFormatFromString(inputFormat);
        cordova.exec(null, null, "VrView", "playVideo", [videoUrl, inputTypeValue, inputFormatValue]);
    },
    playVideoFromAppFolder: function (videoPath, inputType, inputFormat) {
        var inputTypeValue = vrview.getTypeFromString(inputType);
        var inputFormatValue = vrview.getFormatFromString(inputFormat);
        cordova.exec(null, null, "VrView", "playVideoFromAppFolder", [videoPath, inputTypeValue, inputFormatValue]);
    },
    showPhoto: function(photoUrl, inputType) {
        var inputTypeValue = vrview.getTypeFromString(inputType);
        cordova.exec(null, null, "VrView", "showPhoto", [photoUrl, inputTypeValue]);
    },
    showPhotoFromAppFolder: function(photoPath, inputType) {
        var inputTypeValue = vrview.getTypeFromString(inputType);
        cordova.exec(null, null, "VrView", "showPhotoFromAppFolder", [photoPath, inputTypeValue]);
    },
    isDeviceSupported: function(callback) {
        cordova.exec(callback, null, "VrView", "isDeviceSupported", []);
    },
    getTypeFromString: function(typeString) {
        if(typeString == "TYPE_MONO") {
            return vrview.TYPE_MONO;
        } else if(typeString == "TYPE_STEREO_OVER_UNDER") {
            return vrview.TYPE_STEREO_OVER_UNDER;
        } else {
            return undefined;
        }
    },
    getFormatFromString: function(formatString) {
        if(formatString == "FORMAT_DEFAULT") {
            return vrview.FORMAT_DEFAULT;
        } else if(formatString == "FORMAT_HLS") {
            return vrview.FORMAT_HLS;
        } else if(formatString == "FORMAT_DASH") {
            return vrview.FORMAT_DASH;
        } else {
            return undefined;
        }
    },
};
module.exports = vrview;