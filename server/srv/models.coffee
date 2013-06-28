mongoose = require('mongoose')

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# -- Author -----------------------------------------------------------

MoodSchema = new Schema
  image_id: String
  time_stamp: Date
  group_name: String

PickSchema = new Schema
  image_id: String
  picked: String



# -- exports ----------------------------------------------------------

module.exports =
  Mood: mongoose.model('Mood', MoodSchema)
