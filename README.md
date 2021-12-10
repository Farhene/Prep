# PrepProject

## Concept:
    Prep aims to help users to be able to create notes with a category to better organize their notes. They can decide if their note has a date or not to better their schedules and lifestyles. They can also access the notes in the calendar app which will be colored red to notify them that it is like an event and they can see and delete it from there. Users can also delete the category itself, or just the notes from the Feed View, Calendar or even the Dated/Undated Calendar View. 

## Tab Bar Expectations
    - Feed
      - Category Feed Collection View
      - Specific Notes View from Category 
      - Accesses Core Data
      
    - Add Note
      - Uses Core Data
      - Uses DatePicker

    - Calendar
      - Dated events
      - Non-dated events
      - Accesses Core Data
      
    - Random Activity Fragment
      - Use API
      - Uses animation
      - Segue to Add Note via Add to Calendar
      
    - Settings
        - Enables Dark Mode  
  
  ## Required Features :
      - [x] URLSession for REST API Call -> Random Activity View Controller 
      - [ ] Create own delegate protocol
      - [x] Dynamic UITableView && UICollectionView -> Undated, Dated, FeedView, FeedSpecificView Controllers
          - Dynamic collection view in Feed View from Categ Entity -> Feed Collection View Controller
          - Dynamic collection view in Feed Specific View from Notes Entity from Specific Categ clicked  -> Feed Specific Collection View Controller
          - Dynamic table view in Undated -> Undated Table View Controller
          - Dynamic collection view in Calendar's event dates when clicked -> Calendar View Controller -> Dated Collection View Controller
      - [x] Extension of Native Swift -> UIColor
      - [x] At least 3 different scenes
        - Feed Collection View
        - Feed Specific Collection View
        - Calendar View
        - Undated Table View
        - Dated Collection View
        - Settings View
        - Random Activity View
        - Add Note View
    - [x] Animation -> Random Activity View Controller
    - [x] User Defaults: Dark Mode -> Settings View Controller
    - [x] Auto-Layout 
    - [x] Core Data -> In Multiple View Controllers


  ## ToDo/Fix:
      - [x] Fixed Core Data Out of Scope entities issues
      - [x] FSCalendar to have dated notes in the calendar's corresponding dates 
      - [x] Core Data "Note" entity -> one Note to one Category through "notes" relationship for category
      - [x] Core Data "Category" entity -> One to many "Note" through category attribute through note relationship
  
  #### Credits:
      This project was done for iOS Development Course at CUNY Hunter by Farhene Sultana. 
      Some sources used were from Stack Overflow and Youtube and iOS Swift Textbook.
