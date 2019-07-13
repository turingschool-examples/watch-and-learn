import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import  Rails  from 'rails-ujs'

Rails.start()
const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
