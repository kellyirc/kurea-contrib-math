module.exports = (Module) ->
	_ = require 'lodash'
	color = require 'irc-colors'
	parser = require('mathjs')
	
	class MathModule extends Module
		shortName: "Math"
		helpText:
			default: "Evaluates math expressions."
		usage:
			default: "[math|calc] [expression]"
	
		constructor: (moduleManager) ->
			super(moduleManager)
	
			@addRoute "math *", @execute
			@addRoute "calc *", @execute
	
		execute: (origin, route) =>
			expr = route.splats[0]
			try
				result = parser.eval(expr)
				if _.isFunction(result)
					result = "[Function: #{result.name}]"
				@reply origin, "#{origin.user}, your answer is #{color.bold(result)}"
			catch e
				@reply origin, "Unable to evaluate expression: #{e.message}"
	
	
	MathModule