package com.example.varosa_tech

import android.content.Context
import android.view.View
import android.widget.Button
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.StandardMessageCodec

class NativeButtonViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeButtonView(context, viewId, messenger)
    }
}

class NativeButtonView(context: Context, id: Int, messenger: BinaryMessenger) : PlatformView {
    private val button: Button = Button(context)
    private val methodChannel: MethodChannel = MethodChannel(messenger, "varosa_tech/native_button_$id")

    init {
        button.text = "Refresh Battery"
        button.setBackgroundColor(0xFF6C63FF.toInt()) // AppColors.primary
        button.setTextColor(0xFFFFFFFF.toInt()) // White
        button.setPadding(16, 12, 16, 12)
        
        button.setOnClickListener {
            methodChannel.invokeMethod("onButtonPressed", null)
        }
    }

    override fun getView(): View = button

    override fun dispose() {
        // Clean up resources if needed
    }
}
