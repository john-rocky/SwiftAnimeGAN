// The Swift Programming Language
// https://docs.swift.org/swift-book

import Vision
import Foundation
import UIKit

public class SwiftAnimeGANv2 {
        
    private var coreMLRequest: VNCoreMLRequest?
    private lazy var ciContext = CIContext()
    
    public init() {
        do {
            let mlModelConfig = MLModelConfiguration()
            let coreMLModel:MLModel = try animeganHayao(configuration: mlModelConfig).model
            let vnCoreMLModel:VNCoreMLModel = try VNCoreMLModel(for: coreMLModel)
            coreMLRequest = VNCoreMLRequest(model: vnCoreMLModel)
            coreMLRequest?.preferBackgroundProcessing = true
            coreMLRequest?.imageCropAndScaleOption = .scaleFill
        } catch let error {
            coreMLRequest = nil
        }
    }
    
    public func callAsFunction(uiImage: UIImage, orientation: CGImagePropertyOrientation = .up) -> UIImage? {
        guard let coreMLRequest = coreMLRequest else { return nil }
        guard let ciImage = CIImage(image: uiImage) else { return nil }
        let handler = VNImageRequestHandler(ciImage: ciImage,orientation: orientation, options: [:])
        do {
            try handler.perform([coreMLRequest])
            guard let result:VNPixelBufferObservation = coreMLRequest.results?.first as? VNPixelBufferObservation else { return nil }
            let pixelBuffer:CVPixelBuffer = result.pixelBuffer
            let resultCIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let resizedCIImage = resultCIImage.resize(as: CGSize(width: ciImage.extent.size.width,height: ciImage.extent.size.height))
            guard let cgImage = ciContext.createCGImage(resizedCIImage, from: resizedCIImage.extent) else { return nil }
            let resultUIImage = UIImage(cgImage: cgImage)
            return resultUIImage
        } catch {
            print("Vision error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func callAsFunction(ciImage: CIImage, orientation: CGImagePropertyOrientation = .up) -> CIImage? {
        guard let coreMLRequest = coreMLRequest else { return nil }
        let handler = VNImageRequestHandler(ciImage: ciImage,orientation: orientation, options: [:])
        do {
            try handler.perform([coreMLRequest])
            guard let result:VNPixelBufferObservation = coreMLRequest.results?.first as? VNPixelBufferObservation else { return nil }
            let pixelBuffer:CVPixelBuffer = result.pixelBuffer
            let resultCIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let resizedCIImage = resultCIImage.resize(as: CGSize(width: ciImage.extent.size.height,height: ciImage.extent.size.width))
            return resizedCIImage
        } catch {
            print("Vision error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func callAsFunction(cgImage: CGImage, orientation: CGImagePropertyOrientation = .up) -> CGImage? {
        guard let coreMLRequest = coreMLRequest else { return nil }

        let width = cgImage.width
        let height = cgImage.height

        let handler = VNImageRequestHandler(cgImage: cgImage,orientation: orientation, options: [:])
        do {
            try handler.perform([coreMLRequest])
            guard let result:VNPixelBufferObservation = coreMLRequest.results?.first as? VNPixelBufferObservation else { return nil }
            let pixelBuffer:CVPixelBuffer = result.pixelBuffer
            let resultCIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let resizedCIImage = resultCIImage.resize(as: CGSize(width: width,height: height))
            guard let cgImage = ciContext.createCGImage(resizedCIImage, from: resizedCIImage.extent) else { return nil }
            return cgImage
        } catch {
            print("Vision error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func callAsFunction(cvPixelBuffer: CVPixelBuffer, orientation: CGImagePropertyOrientation = .right) -> CVPixelBuffer? {
        guard let coreMLRequest = coreMLRequest else { return nil }

        let width = CVPixelBufferGetWidth(cvPixelBuffer)
        let height = CVPixelBufferGetHeight(cvPixelBuffer)

        let handler = VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer,orientation: orientation, options: [:])
        do {
            try handler.perform([coreMLRequest])
            guard let result:VNPixelBufferObservation = coreMLRequest.results?.first as? VNPixelBufferObservation else { return nil }
            let pixelBuffer:CVPixelBuffer = result.pixelBuffer
            let resultCIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let resizedCIImage = resultCIImage.resize(as: CGSize(width: width,height: height))
            return resizedCIImage.pixelBuffer(cgSize: CGSize(width: width, height: height))
        } catch {
            print("Vision error: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func callAsFunction(named: String, orientation: CGImagePropertyOrientation = .right) -> UIImage? {
        guard let coreMLRequest = coreMLRequest else { return nil }

        guard let uiImage = UIImage(named: named),
              let ciImage = CIImage(image: uiImage)  else { return nil }
        let handler = VNImageRequestHandler(ciImage: ciImage,orientation: orientation, options: [:])
        do {
            try handler.perform([coreMLRequest])
            guard let result:VNPixelBufferObservation = coreMLRequest.results?.first as? VNPixelBufferObservation else { return nil }
            let pixelBuffer:CVPixelBuffer = result.pixelBuffer
            let resultCIImage = CIImage(cvPixelBuffer: pixelBuffer)
            let resizedCIImage = resultCIImage.resize(as: CGSize(width: ciImage.extent.size.height,height: ciImage.extent.size.width))
            let resultUIImage = UIImage(ciImage: resizedCIImage)
            return resultUIImage
        } catch {
            print("Vision error: \(error.localizedDescription)")
            return nil
        }
    }
}

private extension CIImage {
    func resize(as size: CGSize) -> CIImage {
        let selfSize = extent.size
        let transform = CGAffineTransform(scaleX: size.width / selfSize.width, y: size.height / selfSize.height)
        return transformed(by: transform)
    }
    
    func pixelBuffer(cgSize size:CGSize) -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        let width:Int = Int(size.width)
        let height:Int = Int(size.height)

        CVPixelBufferCreate(kCFAllocatorDefault,
                            width,
                            height,
                            kCVPixelFormatType_32BGRA,
                            attrs,
                            &pixelBuffer)

        CIContext().render(self, to: pixelBuffer!)
        return pixelBuffer
    }
}
