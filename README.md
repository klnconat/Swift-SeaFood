# Seafood Classifier

This project is a Swift application that uses CoreML and Vision frameworks to identify seafood items in photos taken from the camera. The app uses the Inceptionv3 CoreML model for image classification and checks the classification result against a predefined list of seafood items. If a seafood item is detected, the app displays "SeaFood" in the navigation bar; otherwise, it shows "NOT SeaFood".

## Features

- **Camera Access**: Allows the user to take a photo using the device's camera.
- **Image Classification**: Uses CoreML's Inceptionv3 model to classify the image.
- **Seafood Detection**: Checks if the classified item matches any item in the seafood list.
- **Result Display**: Shows "SeaFood" or "NOT SeaFood" in the navigation bar based on the classification.

## How It Works

1. **Camera Input**: The app uses `UIImagePickerController` to capture a photo from the device's camera.
2. **Image Conversion**: The captured `UIImage` is converted to `CIImage`, which is required by Vision framework for processing.
3. **CoreML Model Loading**: Inceptionv3 model is loaded with `MLModelConfiguration`.
4. **Classification Request**: A `VNCoreMLRequest` is created to classify the image.
5. **Seafood Check**: The classification result is checked against the predefined `seafoodList` array. If any seafood item is found in the result identifier, "SeaFood" is displayed in the navigation bar; otherwise, "NOT SeaFood" is shown.

## Code Overview

### 1. `ViewController`

The `ViewController` class is responsible for handling the camera input, image processing, and displaying results.

- **Properties**:
  - `imageView`: Displays the image taken by the user.
  - `imagePicker`: Configures and presents the camera.
  - `seafoodList`: A predefined array containing common seafood items.

- **Methods**:
  - `viewDidLoad()`: Sets up the image picker and prepares it to take a photo.
  - `cameraTapped()`: Presents the camera to capture a photo.
  - `imagePickerController(_:didFinishPickingMediaWithInfo:)`: Handles the image selected or taken by the user and passes it to the `detect(image:)` function.
  - `detect(image:)`: Runs the CoreML model on the captured image, processes the classification result, and updates the navigation title based on whether the image contains seafood.

### 2. `seafoodList` Array

This array contains the names of various seafood items, such as "Salmon," "Tuna," "Shrimp," "Crab," etc. The array is used to check if the classified object belongs to any seafood category.
