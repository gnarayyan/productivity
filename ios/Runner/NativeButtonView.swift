import Flutter
import UIKit

class NativeButtonViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeButtonView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeButtonView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var methodChannel: FlutterMethodChannel

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        methodChannel = FlutterMethodChannel(name: "varosa_tech/native_button_\(viewId)", binaryMessenger: messenger!)
        super.init()
        
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView) {
        _view.backgroundColor = UIColor.systemBackground
        
        let button = UIButton(type: .system)
        button.setTitle("Refresh Battery", for: .normal)
        button.backgroundColor = UIColor(red: 0.42, green: 0.39, blue: 1.0, alpha: 1.0) // AppColors.primary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        _view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: _view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: _view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func buttonTapped() {
        methodChannel.invokeMethod("onButtonPressed", arguments: nil)
    }
}
