const args = process.argv.slice(2)

const snake_case_string = (str) => {
  const data = str && str.match(
/[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+/g)
      .map(s => s.toLowerCase())
    .join('_');

  console.log(data)
  return data
}

for(let arg of args){
  snake_case_string(arg)
}

