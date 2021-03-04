package app.carwash.mobile

import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull
import com.facebook.share.model.ShareLinkContent
import com.facebook.share.model.SharePhoto
import com.facebook.share.model.SharePhotoContent
import com.facebook.share.widget.ShareDialog
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "example/procare"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            Log.i("Desde android","el LOG ingreso aqui")
            if(call.method == "hello") {
                val name = call.arguments as String
                result.success(sayHello(name))
            }
            // Note: this method is invoked on the main thread.
            // TODO
        }
    }
    /*
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        FacebookSdk.sdkInitialize(applicationContext)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "example/procare").setMethodCallHandler { call, result ->
            if(call.method == "hello") {
                val name = call.arguments as String
                result.success(sayHello(name))
            }
        }
    }

     */

    private fun sayHello(name: String): String {
        compartirFacebook(name)

        // var photo = SharePhoto.Builder().setImageUrl(Uri.parse(name)).build()
        // var builder = SharePhotoContent.Builder().addPhoto(photo).build()
        // ShareDialog.show(activity, builder)
        // ShareLinkContent content = ShareLinkContent.Builder().setContentUrl(Uri.parse("http://procarewashing.com")).build();
        return "Hola $name desde Android Franz!";
    }

    private fun compartirFacebook(urlImagen: String): Unit {
/*
        var shareDialog = ShareDialog(this)
        var photo = SharePhoto.Builder().setImageUrl(Uri.parse(urlImagen)).build()
        var content = SharePhotoContent.Builder().addPhoto(photo).build()
        shareDialog.show(content)
*/


        var shareDialog = ShareDialog(this)
        var content = ShareLinkContent.Builder()
                .setContentUrl(Uri.parse("http://procarewashing.com")).build()
        shareDialog.show(content)
        
        // ShareLinkContent content = ShareLinkContent.Builder().setContentUrl(Uri.parse("http://procarewashing.com")).build();
    }


}
