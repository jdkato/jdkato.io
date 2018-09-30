var glob = require('glob')
var matter = require('gray-matter')
var toml = require('toml')
var validator = require('jsonschema').Validator

var frontMatterSchema = {
    'id': '/FrontMatter',
    'type': 'object',
    'properties': {
      'tags': {
        'type': 'array',
        'items': {'type': 'string'}
      },
      'categories': {
        'type': 'array',
        'items': {'type': 'string'}
      },
      'title': {'type': 'string'},
      'date': {'type': 'string'},

      'highlight': {'type': 'boolean'},
      'math': {'type': 'boolean'},
      'draft': {'type': 'boolean'},
      'disable_comments':  {'type': 'boolean'},
      'preview':  {'type': 'boolean'}

    },
    'required': ['title', 'date']
};

glob('content/post/*.md', {}, function (er, files) {
    var v = new validator()
    console.log(files)
    files.forEach(function(file, index) {
        fm = matter.read(file, {
            engines: {
                toml: toml.parse.bind(toml),
            },
            language: 'toml',
            delims: ['+++', '+++']
        })
        valid = v.validate(fm.data, frontMatterSchema).valid
        if (!valid) {
            return process.exit(1)
        }
    })
})
