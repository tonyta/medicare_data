//= require jquery

function refreshGraph(data) {
    $('svg').html('');

    var width = 600,
        barHeight = 20;

    var x = d3.scale.linear()
        .domain([0, d3.max(data)])
        .range([0, width - 28]);

    var chart = d3.select(".chart")
        .attr("width", width)
        .attr("height", barHeight * data.length);

    var bar = chart.selectAll("g")
        .data(data)
      .enter()
        .append("g")
        .attr("transform", function(d, i) { return "translate(0," + i * barHeight + ")"; });

    bar.append("rect")
        .attr("width", 0)
        .attr("height", barHeight - 1)
        .transition()
        .ease("elastic")
        .attr("width", x);

    bar.append("text")
        .attr("x", 0)
        .attr("y", barHeight / 2)
        .attr("dy", ".35em")
        .attr("class", "value-text")
        .text(function(d, i) { return d; })
        .transition()
        .delay(250)
        .attr("x", function(d) { return x(d) - 3; });

    bar.append("text")
        .attr("x", 0)
        .attr("y", barHeight / 2)
        .attr("dy", ".35em")
        .attr("class", "price-text")
        .text(function(d, i) { return "$" + 10 * (i + 1); })
        .transition()
        .ease("elastic")
        .attr("x", function(d) { return x(d) + 3; });
}

function updateService(name) {
  $('#service').text(name);
}

$(document).ready(function(){

  $('#hcpcs').on('submit', function(e){
    e.preventDefault();

    $.get('/hcpcs.json', $(this).serialize(), function(response){
      updateService(response.service);
      refreshGraph(response.data);
    });
  });

});