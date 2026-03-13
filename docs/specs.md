# Notus

The goal of this project is to create a simple, yet pleasant note-taking app for the iPad.

## Data

There are 3 models of notes in Notus: pages, notebooks, and notepads.

### Page

Pages represent a single sheet of paper.
They are the most basic unit of data a user can interact with.

All other forms of data (notebooks and notepads) are comprised of pages, just in different ways.

Pages are available as standalone in the file cabinet, or organized as a part of a notebook or notepad.
Pages can be added to notebooks and notepads, rearranged within, and removed from.

### Notebook

A notebook is a collection of pages, organized side-by-side.
Users navigate through by swiping left or right, and can interact with the notebook by writing on the actively displayed page.

### Notepad

A notepad is also a collection of pages, organized vertically.
Notepads are similar to notebooks, but should be continuously scrollable (the user can interact with parts of one page and parts of the page below/above it at the same time).

## View Model

There are 2 view models in Notus: the file cabinet and the desk.

### File Cabinet

The file cabinet is where a user's pages, notebooks, and notepads are stored and can be operated on at a high level.

Operations include:
- Creating pages, notebooks, notepads
- Deleting pages, notebooks, notepads
- Moving pages between notebooks, notepads, and the top-level file cabinet
- Exporting pages, notebooks, and notepads to PDF
- Selecting a page, notebook, or notepad to move to the desk and modify

### Desk

The desk is where users can write/draw in their page, notebook, or notepad as it is where all their drawing tools are located.
Basic drawing tools for now include a pen and an eraser.
You can use Apple's default pen and eraser tools for now.
