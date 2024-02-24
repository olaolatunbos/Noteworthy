// import * as logger from "firebase-functions/logger"
// import * as functions from "firebase-functions/v2"
 
// // 2. initialize the admin SDK
// admin.initializeApp()
 
// // 3. declare the cloud function trigger
// export const makeJobTitleUppercase = functions.firestore.onDocumentWritten(
//   "/notes/{noteId}", (e) => {
//   // 4. defensive code
//   const change = e.data
//   if (change === undefined) {
//     return
//   }
//   const data = change.after.data()
//   if (data === undefined) {
//     // If the document has been deleted, do nothing
//     return
//   }
//   // 5. do the work
//   const uppercase = data.title[1].toUpperCase()

//     if (uppercase == data.title[1]) {
//     return
//   }
//   // 6. log
//   logger.log(`Uppercasing ${change.after.ref.path}: ${data.title} => ${uppercase}`)
//   // 7. write the data back to Firestore
//   return change.after.ref.set({title: uppercase}, {merge: true})
// })

