HTMLWidgets.widget({

  name: 'calheatmapR',

  type: 'output',

  initialize: function(el, width, height) {

    var cal = new CalHeatMap();

    return {
      cal: cal
      // TODO: add instance fields as required
    };
  },

  renderValue: function(el, x, instance) {

    // use html-widget id as itemSelector
    var id = '#' + el.id;
    // start constructing object with attributes to build plot
    var initObj = {
        data: x.data,
        itemSelector: id
    };
    // check if any attributes re. data are provided
    if(x.attrs) {
        initObj = _.extend(initObj, x.attrs);
        initObj.start = new Date(initObj.start);
    }

    instance.cal.init(initObj);

  },

  resize: function(el, width, height, instance) {

  }

});
