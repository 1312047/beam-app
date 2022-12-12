//
//  ScanViewController.swift
//  BeamDemo
//
//  Created by Hudson on 25/10/2021.
//

import AVFoundation
import UIKit

final class ScannerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let image = UIImage(named: "ic_logo")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: 74.4).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.tintColor = .white
        let barButtonItem = UIBarButtonItem(customView: imageView)
        return barButtonItem
    }()

    private lazy var centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45)
        return view
    }()

    private lazy var scanImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_scan"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()

    private lazy var scanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Scan"
        label.font = UIFont(bfont: .poppinsRegular, size: 14)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpCamera()
        setUpUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.view.backgroundColor = .clear
        navigationController?.viewControllers.first?.navigationItem.backBarButtonItem?.tintColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.viewControllers.first?.navigationItem.backBarButtonItem?.tintColor = .none
    }

    private func setUpUI() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let leftCoverView = generateCoverView()
        let rightCoverView = generateCoverView()
        let topCoverView = generateCoverView()
        let bottomCoverView = generateCoverView()
        let verticalBorders = [generateVerticalBorderView(),
                               generateVerticalBorderView(),
                               generateVerticalBorderView(),
                               generateVerticalBorderView()]
        let horizontalBorders = [generateHorizontalBorderView(),
                                 generateHorizontalBorderView(),
                                 generateHorizontalBorderView(),
                                 generateHorizontalBorderView()]
        view.addSubview(centerView)
        view.addSubview(leftCoverView)
        view.addSubview(rightCoverView)
        view.addSubview(topCoverView)
        view.addSubview(bottomCoverView)
        view.addSubview(bottomView)
        bottomView.addSubview(scanImageView)
        bottomView.addSubview(scanLabel)
        verticalBorders.forEach {
            centerView.addSubview($0)
        }
        horizontalBorders.forEach {
            centerView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5),
            centerView.heightAnchor.constraint(equalTo: centerView.widthAnchor),
            leftCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftCoverView.topAnchor.constraint(equalTo: centerView.topAnchor),
            leftCoverView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            leftCoverView.trailingAnchor.constraint(equalTo: centerView.leadingAnchor),
            rightCoverView.leadingAnchor.constraint(equalTo: centerView.trailingAnchor),
            rightCoverView.topAnchor.constraint(equalTo: centerView.topAnchor),
            rightCoverView.bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            rightCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCoverView.topAnchor.constraint(equalTo: view.topAnchor),
            topCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topCoverView.bottomAnchor.constraint(equalTo: centerView.topAnchor),
            bottomCoverView.topAnchor.constraint(equalTo: centerView.bottomAnchor),
            bottomCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalBorders[0].topAnchor.constraint(equalTo: centerView.topAnchor),
            verticalBorders[0].leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            verticalBorders[1].topAnchor.constraint(equalTo: centerView.topAnchor),
            verticalBorders[1].trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            verticalBorders[2].bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            verticalBorders[2].leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            verticalBorders[3].bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            verticalBorders[3].trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            horizontalBorders[0].topAnchor.constraint(equalTo: centerView.topAnchor),
            horizontalBorders[0].leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            horizontalBorders[1].topAnchor.constraint(equalTo: centerView.topAnchor),
            horizontalBorders[1].trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            horizontalBorders[2].bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            horizontalBorders[2].leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            horizontalBorders[3].bottomAnchor.constraint(equalTo: centerView.bottomAnchor),
            horizontalBorders[3].trailingAnchor.constraint(equalTo: centerView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            scanImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -10),
            scanImageView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            scanImageView.widthAnchor.constraint(equalToConstant: 22),
            scanImageView.heightAnchor.constraint(equalToConstant: 22),
            scanLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            scanLabel.topAnchor.constraint(equalTo: scanImageView.bottomAnchor, constant: 8)
        ])
    }

    private func generateCoverView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        return view
    }

    private func generateVerticalBorderView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }

    private func generateHorizontalBorderView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.widthAnchor.constraint(equalToConstant: 48).isActive = true
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }

    private func setUpCamera() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        if captureSession.canAddInput(videoInput) == true {
            captureSession.addInput(videoInput)
        } else {
            failed()
        }
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) == true {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession?.startRunning()
    }

    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported",
                                   message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }

    private func found(code: String) {
        print(code)
        let vc = AddProductViewController(product: generateRandomProduct())
        navigationController?.pushViewController(vc, animated: true)
    }

    private func generateRandomProduct() -> Product {
        let names = ["EF 50mm f/1.8 STM Lens",
                     "EOS 760D/Rebel T6s/800",
                     "EOS 800D/Rebel T7i/K",
                     "EOS 250D/Rebel SL3/K",
                     "EOS 20D", "EOS-1D M",
                     "EOS-1D X Mark III"]
        let desc = "One of the most versatile focal lengths available, the EF 50mm f/1.8 STM Lens from Canon is a compact, normal-length prime well-suited to everyday shooting. The bright f/1.8 maximum aperture benefits working in difficult lighting conditions and also affords increased control over depth of field for isolating subject matter."
        return Product(id: Int.random(in: 1...1000),
                       name: names.randomElement()!,
                       description: desc)
    }
}
