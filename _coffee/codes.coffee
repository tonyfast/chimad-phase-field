data_file = "data/codes.json"

add_logo = (selection) ->
  subselection = selection.filter((d) -> "logo" of d)
  subselection = subselection.append("div").attr("class", "logo")
  return subselection.append("img").attr("src", (d) -> d.logo)

add_header = (selection) ->
  subselection = selection.filter((d) -> "name" of d)
  return subselection.append("h4").attr("class", "codeheader").text((d) -> d.name)

add_description = (selection) ->
  subselection = selection.filter((d) -> "description" of d)
  return subselection.append("p").text((d) -> d.description)

add_stats = (selection) ->
  subselection = selection.filter((d) -> "stats" of d)
  subselection.append("h5").text("Stats")
  table = subselection.append("table").attr("class", "indent")
  tr = table.selectAll().data((d) -> d3.entries(d.stats)).enter().append("tr")
  tr.append("td").html((d) -> d.key + ":&nbsp;")
  tr.append("td").text((d) -> d.value)

icons =
  github:
    html: '<i class="fa fa-github fa-2x"></i>'
    title: "GitHub"
  home:
    html: '<i class="fa fa-home fa-2x"></i>'
    title: "Home"
  openhub:
    html: '<img src="images/OH_logo-24x24.png" class="icon">'
    title: "OpenHub"
  test:
    html: '<i class="fa fa-tasks fa-2x"></i>'
    title: "Test"

add_icon = (selection) ->
  subselection = selection.filter((d) -> d.key of icons)
  subselection.attr("href", (d) -> d.value)
  subselection.attr("title", (d) -> icons[d.key].title)
  subselection.html((d) -> icons[d.key].html)
  
add_icons = (selection) ->
  subselection = selection.filter((d) -> "urls" of d)
  div = subselection.append("div").attr("class", "icons")
  a = div.selectAll().data((d) -> d3.entries(d.urls)).enter().append("a")
  add_icon(a)
  
build_function = (data) ->
  selection = d3.select("#codes").selectAll()
  .data(data).enter()
  .append("div").attr("class", "col-md-4")
  .append("div").attr("class", "card")

  add_logo(selection)
  add_header(selection)
  add_description(selection)
  add_stats(selection)
  add_icons(selection)

d3.json(data_file, build_function)

