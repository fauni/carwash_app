package app.carwash.mobile

import android.net.Uri
import android.os.Bundle
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

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "example/procare").setMethodCallHandler { call, result ->
            if(call.method == "hello") {
                val name = call.arguments as String
                result.success(sayHello(name))
            }
        }
    }

     */

    private fun sayHello(name: String): String {
        var photo = SharePhoto.Builder().setImageUrl(Uri.parse(name)).build()

        var builder = SharePhotoContent.Builder().addPhoto(photo).build()
        // builder = builder.setContentUrl(Uri.parse("https://developers.facebook.com"))

        ShareDialog.show(activity, builder)
        // ShareLinkContent content = ShareLinkContent.Builder().setContentUrl(Uri.parse("https://developers.facebook.com")).build();
        return "Hola $name desde Android Franz!";
    }


}
