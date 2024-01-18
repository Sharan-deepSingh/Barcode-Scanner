//
//  ScannerViewController.swift
//  Barcode Scanner
//
//  Created by Sharandeep Singh on 16/01/24.
//

import UIKit
import AVFoundation

enum CameraErrors: String {
    case invalidDeviceInput = "We are unable to capture the video"
    case invalidScannedValue = "Video scanned is not valid"
}


protocol ScannerViewControllerDelegate: AnyObject {
    func didFind(barCode: String)
    func didSurfaceError(error: CameraErrors)
}


final class ScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: ScannerViewControllerDelegate!
    
    init(delegate: ScannerViewControllerDelegate) {
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer?.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        guard captureSession.canAddInput(videoInput) else {
            delegate.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        captureSession.addInput(videoInput)
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.qr, .ean8, .ean13]
        } else {
            delegate.didSurfaceError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            delegate.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            delegate.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        guard let barCode = machineReadableObject.stringValue else {
            delegate.didSurfaceError(error: .invalidScannedValue)
            return
        }
        
        delegate.didFind(barCode: barCode)
    }
}
