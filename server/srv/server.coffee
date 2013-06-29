# express-mongoose-crud example

coffee = require('coffee-script')
express = require('express')
mongoose = require('mongoose')
express_mongoose_crud = require('../src/index')

path = require('path')

models = require('./models')
request = require('request')

db = mongoose.connect("mongodb://localhost/songs")

app = module.exports = express.createServer()
app.configure ->
  app.set "views", path.join(__dirname, "/views")
  app.set "view engine", "ejs"
  app.set "view options", { layout: false }
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(secret: 'everyone knows')
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.enable("jsonp callback")

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

app.configure "test", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

get_or_create_model = (model, search_field, data, cb) ->
  search_criteria = {}
  search_criteria[search_field] = data[search_field]
  model.findOne search_criteria, (err, item) ->
    throw err  if err
    if item
      cb(item)
    else
      model.create data, (err, item) ->
        throw err  if (err)
        cb(item)

# get_or_create_model models.Mood, 'name', {
#   image_id: '1'
#   time_stamp: 'now'
#   group_name:'grp'
# }, (mood) ->
#   console.log 'mood created'

`
app.get('/test',function(req,res,next){
  request('http://api.guitarparty.com/v2/songs/\?query\=black+eyed+peas', {headers:{'Guitarparty-Api-Key': "32ba2951d572564b735ef94943f6219eba696cd5"}}, function (error, response, body) {
    console.log(body)
    jsonBody = JSON.parse(body);
    res.json(jsonBody)
  })
});

app.get('/songs/:query',function(req,res,next){
  request('http://api.guitarparty.com/v2/songs/\?query\=' + req.params.query, {headers:{'Guitarparty-Api-Key': "32ba2951d572564b735ef94943f6219eba696cd5"}}, function (error, response, body) {
    console.log(body)
    jsonBody = JSON.parse(body);
    res.json(jsonBody)
  })
});
`



r_mood = new express_mongoose_crud.Resource
  model: models.Mood
r_mood.mount(app)


if process.env.NODE_ENV != 'test'
  app.listen 8080, "127.0.0.1", ->
    console.log "Express server listening on %d in %s mode", app.address().port, app.settings.env
