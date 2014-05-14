# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(".jquery-ui-date").datepicker()

jQuery ->
	$(".toggleDayLink").click ->
		$("#toggle_div_days").toggle()
	$(".toggleWeekLink").click ->
		$("#toggle_div_weeks").toggle()
	$(".toggleMonthLink").click ->
		$("#toggle_div_months").toggle()
	$(".toggleBiannualLink").click ->
		$("#toggle_div_biannuals").toggle()
	$(".toggleYearLink").click ->
		$("#toggle_div_years").toggle()
	return
