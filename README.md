# PrepProject

###Concept

###Goals
- Feed
  - Category Feed Collection View
  - Categorical Specific Table View
  - Specific Note View
  - Accesses Core Data
  
- Add Note
  - Uses Core Data

- Calendar
  - Dated events
  - Non-dated events
  
- Random Activity Fragment
  - Use API
  - Uses animation
  
  ##Issues
  - issues with Entity in AddNote tab! startDate is being a problem.
  
  ##Finished:
  - Core Data "Note" entity -> one Note to one Category through "notes" relationship for category
  - Core Data "Category" entity -> One to many "Note" through category attribute through note relationship
  - Random Generator View Controller
  - Extension of Native Swift -> UIColor
  - REST API Call done
  - Animation 
  - At least 3 different scenes with dynamic data
  - Dark mode -> User Defaults
  
  ##ToDo:
  - Auto-Layout
  - Fix Core Data Out of Scope entities issues
  - Create own delegate protocol
  - Dynamic table view in Undated
  - Dynamic collection views in Feed and Feed Specific
  - FSCalendar to have dated notes in the calendar's corresponding dates 
