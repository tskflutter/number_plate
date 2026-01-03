# Project Folder Structure

# Standard Operating Procedure for ViserLab Flutter Team Project Checking

 ## *1. Design Checking:*
>
 > - **Spacing:** Ensure consistent and appropriate spacing between UI elements.
 > - **Font:** Verify consistent and legible font usage throughout the application.
 > - **Content Validation:** Make sure you use valid content(text) for each section.
 > - **Image Ratio:** Check image dimensions and aspect ratios for consistency and suitability.
 > - **Matching Design with Figma (if applicable):** Ensure alignment with design specifications provided in Figma.
 > - **Responsiveness Check:** Ensure the application adapts correctly to various screen sizes and orientations.
 > - **Release and Debug Testing:** Test the application in both release and debug modes to identify any potential issues or discrepancies.


 ## *2. Code Structure Checking:*
>
> - **Naming Conventions:** Review for adherence to established naming conventions for functions, variables, files, and folders.
> - **Folder Structure Maintenance:** Ensure the organization and cleanliness of project directories and files.
> - **Code Length Limitation:** Confirm that no screen exceeds 150 - 250 lines of code to maintain readability and manageability.
> - **Unique Widget Usage:** Ensure each section of a page is represented by a unique widget to promote modularity and reusability.
> - **Local and Global Widget Maintenance:** Check that both local and global widgets are maintained properly to prevent redundancy and improve code clarity.
> - **Error Handling Approach:** Verify the effectiveness of error handling mechanisms.
> - **Model Class:** Check each model class are maintained global structure and there is no int,double,number type variable without id. Even if any variable are in string but there is a possibility to be in integer in some server then you have to call .toString()
## *3. Coding Rules:*
> - **File, Folder, and Widget Naming:** Use snake case for file, folder, and widget names.
> - **Widget Placement:** Place reusable widgets in the global component section if used in multiple screens; otherwise, place them in the single-screen widget section.
> - **Widget Modularity:** Ensure each section of a page (screen) is represented by a unique widget to avoid clutter and promote maintainability.
> - **Rendering Issues:** Check the application for rendering issues and inspect the console for any additional errors.
> - **Unused Imports:** Remove any unused import statements to maintain a clean and efficient codebase.
> - **Spacing and Translation:** Maintain proper spacing and use translation (tr) for both static and dynamic text to ensure consistency and support internationalization.
> - **Text Size and Content Spacing:** Verify that text size and content spacing are consistent across all sections of the application for a cohesive user experience.
> - **Asset Management:** Check there is any used image,font or anyother asset in the project .If any unused assets are found then delete them and make sure you project don’t contain any unused  assets.
> - **Model Class Checking:** Make sure each string variable contain tostring method and without id we don’t keep any variable as a int or double each or everything will be forcefully string even it comes in string  thoug you have to  use .toString() method to each variable.
   
## Before sending code for review, developers should ensure the following cases are addressed. Team leaders should also verify the following:
>
> - **Content and Image Validation:** Validate that each section of the application uses appropriate content and images.
> - **Translation and RTL Design:** Ensure correct usage of translations (tr) across screens and make sure your app translation will work properly for dynamic data. Also, ensure the application works properly in RTL mode.
> - **Unused Resource Removal:** Remove unused strings, images, and assets to maintain a clean and efficient codebase.
> - **User Testing:** Test your app by new user also a existing user with more data. Also you have to test your app by social login to ensure all features perform as expected.
> - **Functionality Verification:** Ensure each functionality are working properly including reset password and strong password section. Also check each section(which can be enable/disable by general settings) are change based on admin panel action.
> - **Package Version Update:** Ensure all packages are updated to their latest versions.
> - **Resource Optimization:** Identify and remove unnecessary resources in the codebase to enhance performance and maintainability.
> - **Native Permission Checking:** Confirm that permissions and other dependencies are correctly configured in the Android and iOS folders.
> - **Unnecessary Comment Removal:** Remove any unnecessary comments from the codebase.
> - **Section Data Validation:** Validate each page/section to ensure all required data is present. Seek backend support if data insertion is not feasible.
> - **Asset Folder Architecture:** Verify that the asset folder structure adheres to best practices, including proper placement of app logos and icons based on Flutter's guidelines.
> - **Push Notification Verification:** Make sure push notification are work properly. Before set push notification ask your team leader about app name then change app package name , after setting app name then setup and test push notification.
> - **Release and Debug Testing:** Test the application thoroughly in both release and debug modes to detect and resolve any potential issues or inconsistencies.

<br><br/>
<br><br/>
<br><br/>

## Additional Note: 
### Check In-App-Webview Configuration
### Check Url Launcher Platform Specific Configuration
### If you use Image Picker then check your Info.plist folder contain below description
>
> - NSPhotoLibraryUsageDescription
> - NSCameraUsageDescription
> - NSMicrophoneUsageDescription
> - For Mac you have to add below permission <key>com.apple.security.files.user-selected.read-only</key>
    <true/>

## Check url_launcher Platform Specific Configuration


# Typography Specification

This document outlines the typography styles used in the project. Each typography style is defined by its **name**, **size**, **weight**, and **spacing**.

## Typography Table

| **Name**          | **Size** | **Weight** | **Spacing** |
|-------------------|----------|------------|-------------|
| `displayLarge`    | 57.0     | w600       | -1.5        |
| `displayMedium`   | 45.0     | w600       | -0.5        |
| `displaySmall`    | 36.0     | w400       | 0.0         |
| `headlineLarge`   | 24.0     | w600       | 0.25        |
| `headlineMedium`  | 20.0     | w600       | 0.25        |
| `headlineSmall`   | 17.0     | w600       | 0.0         |
| `titleLarge`      | 22.0     | w600       | 0.15        |
| `titleMedium`     | 18.0     | w600       | 0.15        |
| `titleSmall`      | 14.0     | w600       | 0.1         |
| `bodyLarge`       | 16.0     | w400       | 0.5         |
| `bodyMedium`      | 13.0     | w400       | 0.25        |
| `bodySmall`       | 11.0     | w400       | 0.4         |
| `labelLarge`      | 16.0     | w400       | 1.25        |
| `labelMedium`     | 14.0     | w400       | 1.25        |
| `labelSmall`      | 12.0     | w400       | 1.5         |

## Definitions

- **Size**: The font size in points (pt).
- **Weight**: The font weight, indicating the boldness of the text (e.g., `light`, `regular`, `medium`).
- **Spacing**: The letter spacing in points (pt).

---

Feel free to use these styles to ensure consistency across your application.
