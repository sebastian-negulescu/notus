# Notus

**Goal**: As close to pen and paper as you can get.

## Features

- Maximal drawing area
- Easy flow between drawing tool, eraser, undo/redo
- Configure active drawing tool and eraser
- Select between pen colours and thicknesses
- Select between object erase and pixel erase, configure the eraser size
- Add different tools like highlighter, lasso, on-screen ruler, and on-screen protractor
- Configurable page background
- Selectable paper style between lined, grid, dot, and iso and control spacing
- Selectable paper colour
- Cut, copy, paste images
- (Comes with lasso) Cut, copy, paste writing AND images
- Links to page sections (this might not be possible)
- Pages that hold writing
- Namable pages
- Taggable pages
- Filtering pages by tag
- Books that are made of pages
- Namable books
- Taggable books
- The ability to reorder pages in a book
- The ability to move pages in and out of a book
- A "file cabinet" that persistently holds all pages and books
- The ability to export a page as a PDF
- The ability to export a book as a PDF
- The ability to create folders in the file cabinet
- The ability to add and remove folders, pages, and books into other folders
- The ability to create a page from the file cabinet
- The ability to create a book from the file cabinet
- Delete a page from the file cabinet
- Delete a book from the file cabinet
- Create a restorable archive of the file cabinet
- Rename a book from the file cabinet
- Rename a page from the file cabinet

### Page

Simplest drawable view.

Serializeable struct with fields:
- UUID
- Name
- Tags
- Links (each link is a struct with coords, dimensions, and UUID it maps to)
- Canvas

### Desk

Place where we modify pages.

Loads page, and persists either on each modification or on file away.

What should we be able to do from the Desk?
- File away the current page
- View and modify the name
- View and modify tags
- Export to PDF
- Change background colour
- Change background pattern
- Change primary tool
- Change secondary tool
- Import image
- Insert links to other pages

Tabs:
- Admin
    - Name
    - Tags
    - Creation date
    - File away
    - Export
    - Delete
- Tools
    - Change primary tool
    - Change secondary tool
- Paper
    - Change background
        - Colour
        - Pattern
    - Import image
    - Insert link

Realistically, we could probably combine the tools and paper stationery tabs.
Though two tabs feels worse than three.
