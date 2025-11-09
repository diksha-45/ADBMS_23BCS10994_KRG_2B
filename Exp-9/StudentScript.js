// ===================== STUDENT DATABASE SETUP =====================
use school_db

// ======================= INSERT OPERATIONS =======================

// Insert a single student
db.students.insertOne({
  roll_no: 101,
  name: "Aarav Sharma",
  class: "10A",
  age: 15,
  gender: "Male",
  marks: { math: 88, science: 92, english: 85, social: 90 },
  attendance: 96,
  address: { city: "Delhi", state: "Delhi", pincode: 110001 },
  hobbies: ["Reading", "Cricket"],
  active: true
});

// Insert multiple students
db.students.insertMany([
  {
    roll_no: 102,
    name: "Diya Patel",
    class: "10A",
    age: 14,
    gender: "Female",
    marks: { math: 92, science: 89, english: 94, social: 91 },
    attendance: 98,
    address: { city: "Ahmedabad", state: "Gujarat", pincode: 380015 },
    hobbies: ["Dancing", "Drawing"],
    active: true
  },
  {
    roll_no: 103,
    name: "Rohan Singh",
    class: "10B",
    age: 15,
    gender: "Male",
    marks: { math: 75, science: 80, english: 78, social: 82 },
    attendance: 89,
    address: { city: "Lucknow", state: "Uttar Pradesh", pincode: 226010 },
    hobbies: ["Football", "Music"],
    active: true
  },
  {
    roll_no: 104,
    name: "Sneha Iyer",
    class: "10A",
    age: 15,
    gender: "Female",
    marks: { math: 85, science: 87, english: 90, social: 88 },
    attendance: 95,
    address: { city: "Chennai", state: "Tamil Nadu", pincode: 600001 },
    hobbies: ["Singing", "Photography"],
    active: true
  },
  {
    roll_no: 105,
    name: "Kabir Khan",
    class: "10C",
    age: 16,
    gender: "Male",
    marks: { math: 68, science: 72, english: 70, social: 75 },
    attendance: 80,
    address: { city: "Mumbai", state: "Maharashtra", pincode: 400001 },
    hobbies: ["Gaming", "Cycling"],
    active: false
  }
]);

// ======================= READ OPERATIONS =======================

// Find all students
db.students.find();

// Find one student
db.students.findOne();

// Find only name and class (excluding _id)
db.students.find({}, { _id: 0, name: 1, class: 1 });

// Find students with attendance above 90%
db.students.find({ attendance: { $gt: 90 } });

// Find students from Delhi
db.students.find({ "address.city": "Delhi" });

// ======================= UPDATE OPERATIONS =======================

// Update marks of one student
db.students.updateOne(
  { roll_no: 103 },
  { $set: { "marks.math": 82, "marks.science": 85 } }
);

// Add a new hobby to a student
db.students.updateOne(
  { roll_no: 102 },
  { $push: { hobbies: "Yoga" } }
);

// Remove a hobby
db.students.updateOne(
  { roll_no: 105 },
  { $pull: { hobbies: "Gaming" } }
);

// Update many students — add a new field
db.students.updateMany({}, { $set: { school: "Bright Future High School" } });

// Remove a field (example: remove 'active' field)
db.students.updateOne(
  { roll_no: 105 },
  { $unset: { active: "" } }
);

// Upsert — update or insert if not exists
db.students.updateOne(
  { roll_no: 106 },
  {
    $set: {
      name: "Meera Das",
      class: "10B",
      age: 14,
      gender: "Female",
      marks: { math: 90, science: 93, english: 89, social: 94 },
      attendance: 99
    }
  },
  { upsert: true }
);

// ======================= DELETE OPERATIONS =======================

// Delete one student
db.students.deleteOne({ roll_no: 105 });

// Delete all inactive students
db.students.deleteMany({ active: false });

// Delete all records
// db.students.deleteMany({});

// ======================= AGGREGATION OPERATIONS =======================

// Group by class – count students
db.students.aggregate([
  {
    $group: {
      _id: "$class",
      total_students: { $sum: 1 }
    }
  }
]);

// Calculate average marks in each class (based on math)
db.students.aggregate([
  {
    $group: {
      _id: "$class",
      avg_math_marks: { $avg: "$marks.math" }
    }
  }
]);

// Group by gender – count
db.students.aggregate([
  {
    $group: {
      _id: "$gender",
      total: { $sum: 1 }
    }
  }
]);

// Find top 3 students by total marks
db.students.aggregate([
  {
    $addFields: {
      total_marks: {
        $add: ["$marks.math", "$marks.science", "$marks.english", "$marks.social"]
      }
    }
  },
  { $sort: { total_marks: -1 } },
  { $limit: 3 },
  { $project: { _id: 0, name: 1, class: 1, total_marks: 1 } }
]);
