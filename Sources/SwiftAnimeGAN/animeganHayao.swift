//
// animeganHayao.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class animeganHayaoInput : MLFeatureProvider {

    /// test__0 as color (kCVPixelFormatType_32BGRA) image buffer, 256 pixels wide by 256 pixels high
    var test__0: CVPixelBuffer

    var featureNames: Set<String> {
        get {
            return ["test__0"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "test__0") {
            return MLFeatureValue(pixelBuffer: test__0)
        }
        return nil
    }
    
    init(test__0: CVPixelBuffer) {
        self.test__0 = test__0
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    convenience init(test__0With test__0: CGImage) throws {
        self.init(test__0: try MLFeatureValue(cgImage: test__0, pixelsWide: 256, pixelsHigh: 256, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    convenience init(test__0At test__0: URL) throws {
        self.init(test__0: try MLFeatureValue(imageAt: test__0, pixelsWide: 256, pixelsHigh: 256, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!)
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func setTest__0(with test__0: CGImage) throws  {
        self.test__0 = try MLFeatureValue(cgImage: test__0, pixelsWide: 256, pixelsHigh: 256, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func setTest__0(with test__0: URL) throws  {
        self.test__0 = try MLFeatureValue(imageAt: test__0, pixelsWide: 256, pixelsHigh: 256, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class animeganHayaoOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// image as color (kCVPixelFormatType_32BGRA) image buffer, 256 pixels wide by 256 pixels high
    var image: CVPixelBuffer {
        return self.provider.featureValue(for: "image")!.imageBufferValue!
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(image: CVPixelBuffer) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["image" : MLFeatureValue(pixelBuffer: image)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class animeganHayao {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "animeganHayao", withExtension:"mlmodelc")!
    }

    /**
        Construct animeganHayao instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of animeganHayao.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `animeganHayao.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct animeganHayao instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct animeganHayao instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct animeganHayao instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<animeganHayao, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct animeganHayao instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> animeganHayao {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct animeganHayao instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<animeganHayao, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(animeganHayao(model: model)))
            }
        }
    }

    /**
        Construct animeganHayao instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> animeganHayao {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return animeganHayao(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as animeganHayaoInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as animeganHayaoOutput
    */
    func prediction(input: animeganHayaoInput) throws -> animeganHayaoOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as animeganHayaoInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as animeganHayaoOutput
    */
    func prediction(input: animeganHayaoInput, options: MLPredictionOptions) throws -> animeganHayaoOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return animeganHayaoOutput(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        - parameters:
           - input: the input to the prediction as animeganHayaoInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as animeganHayaoOutput
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, *)
    func prediction(input: animeganHayaoInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> animeganHayaoOutput {
        let outFeatures = try await model.prediction(from: input, options:options)
        return animeganHayaoOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - test__0 as color (kCVPixelFormatType_32BGRA) image buffer, 256 pixels wide by 256 pixels high

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as animeganHayaoOutput
    */
    func prediction(test__0: CVPixelBuffer) throws -> animeganHayaoOutput {
        let input_ = animeganHayaoInput(test__0: test__0)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [animeganHayaoInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [animeganHayaoOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [animeganHayaoInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [animeganHayaoOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [animeganHayaoOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  animeganHayaoOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
