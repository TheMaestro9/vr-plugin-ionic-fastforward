package it.tangodev.cordovapluginvrview;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

import android.net.Uri;

import android.os.Build;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

public class VrView extends CordovaPlugin {
    private static final String TAG = "VrView";
    private static final int SOURCE_TYPE_URL = 1;
    private static final int SOURCE_TYPE_ASSET_PATH = 2;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Context context = this.cordova.getActivity().getApplicationContext();
        Log.d(TAG, "Args: " + args.toString());
        if (action.equals("playVideo")) {
            playVideo(SOURCE_TYPE_URL, context, args);
            return true;
        } else if (action.equals("playVideoFromAppFolder")) {
            playVideo(SOURCE_TYPE_ASSET_PATH, context, args);
            return true;
        } else if (action.equals("showPhoto")) {
            showPhoto(SOURCE_TYPE_URL, context, args);
            return true;
        } else if (action.equals("showPhotoFromAppFolder")) {
            showPhoto(SOURCE_TYPE_ASSET_PATH, context, args);
            return true;
        } else if(action.equals("isDeviceSupported")) {
            int result = isDeviceSupported() ? 1 : 0;
            callbackContext.success(result);
            return true;
        } else {
            return false;
        }
    }

    private boolean isDeviceSupported() {
        int currentApiVersion = android.os.Build.VERSION.SDK_INT;
        return currentApiVersion >= Build.VERSION_CODES.KITKAT;
    }

    private void onDeviceNotSupported() {
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                Context context = VrView.this.cordova.getActivity().getApplicationContext();
                Toast toast = Toast.makeText(context, "Device not supported", Toast.LENGTH_SHORT);
                toast.show();
            }
        });
    }

    private void playVideo(int sourceType, Context context, JSONArray args) throws JSONException {
        if(!isDeviceSupported()) {
            onDeviceNotSupported();
            return;
        }
        Intent intent = new Intent(context, VrVideoActivity.class);
        intent.setAction(Intent.ACTION_VIEW);

        if(sourceType == SOURCE_TYPE_URL) {
            intent.setData(Uri.parse(args.getString(0)));
        } else {
            intent.putExtra("videoAssetPath", "www/" + args.getString(0));
        }

        if(!args.isNull(1)) {
            intent.putExtra("inputType", args.getInt(1));
        }
        if(!args.isNull(2)) {
            intent.putExtra("inputFormat", args.getInt(2));
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }

    private void showPhoto(int sourceType, Context context, JSONArray args) throws JSONException {
        if(!isDeviceSupported()) {
            onDeviceNotSupported();
            return;
        }
        Intent intent = new Intent(context, VrPanoramaActivity.class);
        intent.setAction(Intent.ACTION_VIEW);

        if(sourceType == SOURCE_TYPE_URL) {
            intent.setData(Uri.parse(args.getString(0)));
        } else {
            intent.putExtra("photoAssetPath", "www/" + args.getString(0));
        }

        if(!args.isNull(1)) {
            intent.putExtra("inputType", args.getInt(1));
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }
}