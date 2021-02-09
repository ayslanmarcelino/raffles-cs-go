export { colors };

var colors = function(count_labels){
  var array_colors = []
  for (let index = 0; index < count_labels; index++) {
    array_colors.push(get_random_color())
  }
  return array_colors;
}

var get_random_color = function(){
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}
