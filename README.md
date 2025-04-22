# FetchTakeHome

### Summary: Include screen shots or a video of your app highlighting its features
The app displays the list of recipes, with a functional refresh button, a recipe detail view for each recipe, and a favorites tab showing the recipes starred by the user. 

<p align="center">
  <img src="https://github.com/user-attachments/assets/d077adc6-a9ed-4ded-8be1-d738df151f6c" width="250" alt="List View" />
  <img src="https://github.com/user-attachments/assets/48ca1779-5fb9-4496-9da7-16c3f5de4edd" width="250" alt="Detail View" />
  <img src="https://github.com/user-attachments/assets/5233c8a3-becf-4361-a5c3-7590b0ce72fb" width="250" alt="Favorites View" />
</p>


https://github.com/user-attachments/assets/b412c4da-34ea-4990-bca0-622071b9bbf5

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to prioritize the core logic and architecture of the app, ensuring it effectively gets recipes while conforming to MVVM architecture. The view effectively goes to get the recipes, and if they've already been downloaded and saved, it uses those, otherwise or on refresh it downloads them from the JSON, saving images when needed. A focus on this logic and architecture, stressing separation of responsibilities, was stressed so that changes such as adding the large image into the detailsView was easy and required minimal changes due to the separation of classes. The core functionality of the app and with a clean architecture makes for easy scalability, which is important when adding to an existing codebase.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 14 hours on the project, about 2 hours planning the architecture and data flow, 5 hours building the main logic of downloading and saving data, 1 hour implementing the favorites feature, 3 hours on the UI, 1 hour writing and running tests, 2 hours refactoring code.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
One trade‑off I made for the sake of time and simplicity was persisting the recipes data as a single JSON file rather than using Core Data or some other database. Because of this, if I was to implement sorting, filtering, or searching, it would have to be done after loading the full array. Had I used Core Data, or some other indexed persistent store, filtering features would be easier to implement. Another trade‑off is relying on singletons, like FavoritesManager, RecipeModelFileManager, and RecipeStorageManager, rather tham injecting those dependencies. This was done because of time constraints, and seems fine in a smaller, simple codebase as this, but it comes at the cost of testability and flexibility. With more time I would introduce dependency injection so I can swap in mocks for unit tests and scale the architecture more cleanly.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think the weakest part of the project is the lack of polish with regards to the UI and to error handling. Given more time I would have added animations for the UI, transitions between views, and had placeholder images for recipes without images, rather than just showing a progressView. Also, for example, when a recipe is favorited, the star just instantly turns yellow, and the project would have been stronger if features like this came with an animation, haptic feedback, and sound. While main errors are caught, like invalid data or invalid URL, others like timeout errors or corrupted disk errors are not distinguished and communicated to the user, making another weak point of the project which I would have corrected given more time.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Due to building this under a time constraint, I focused on delivering a complete, reliable implementation rather than one which is properly polished. I chose effective yet simple solutions, with the understanding that I could swap in Core Data, dependency injection, or more complete error handling as the codebase matured. I’d be excited to discuss how I’d expand on this current implementation in future iterations.
