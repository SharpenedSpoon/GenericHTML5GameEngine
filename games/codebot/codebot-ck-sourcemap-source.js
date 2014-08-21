// Generated by CoffeeScript 1.7.1

/*
--------------------------------------------
     Begin _debug.coffee
--------------------------------------------
 */

(function() {
  var CodebotGameObject, Debug, GameObject, KeyCode, Robot, awake, beginGameLoop, canvas, context, createGameObjects, drawCircle, drawLine, drawPolygon, drawSquare, drawText, dt, dtStep, fixedUpdate, frame, frames, gameObjects, last, now, paused, render, start, step, timestamp, update,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Debug = {
    getTime: function() {
      var now;
      now = new Date();
      return now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
    },
    Log: function(txt) {
      var oldHtml;
      oldHtml = $('#debug').html();
      if (oldHtml !== '') {
        oldHtml = oldHtml + '<br/>';
      }
      return $('#debug').html(oldHtml + this.getTime() + ' - ' + txt);
    }
  };


  /*
  --------------------------------------------
       Begin _drawing-functions.coffee
  --------------------------------------------
   */

  drawSquare = function(x, y, w, h, color) {
    if (color == null) {
      color = '#000000';
    }
    context.fillStyle = color;
    context.fillRect(x, y, w, h);
    return null;
  };

  drawLine = function(x1, y1, x2, y2, color) {
    if (color == null) {
      color = '#000000';
    }
    context.beginPath();
    context.moveTo(x1, y1);
    context.lineTo(x2, y2);
    context.strokeStyle = color;
    context.stroke();
    return null;
  };

  drawPolygon = function(vertexArray, color) {
    var firstVertex, vertex, _i, _len;
    if (color == null) {
      color = '#000000';
    }
    context.beginPath();
    firstVertex = vertexArray[0];
    context.moveTo(firstVertex[0], firstVertex[1]);
    for (_i = 0, _len = vertexArray.length; _i < _len; _i++) {
      vertex = vertexArray[_i];
      context.lineTo(vertex[0], vertex[1]);
    }
    context.lineTo(firstVertex[0], firstVertex[1]);
    context.strokeStyle = color;
    return context.stroke();
  };

  drawText = function(txt, x, y) {
    return context.fillText(txt, x, y);
  };

  drawCircle = function(x, y, radius, color, fill, lineWidth) {
    if (color == null) {
      color = '#000000';
    }
    if (fill == null) {
      fill = false;
    }
    if (lineWidth == null) {
      lineWidth = 1;
    }
    context.beginPath();
    context.arc(x, y, radius, (Math.PI / 180) * 0, (Math.PI / 180) * 360, true);
    if (fill) {
      context.fillStyle = color;
      context.fill();
    } else {
      context.lineWidth = lineWidth;
      context.strokeStyle = color;
      context.stroke();
    }
    return context.closePath();
  };


  /*
  --------------------------------------------
       Begin _game-loop-bootstrap.coffee
  --------------------------------------------
   */

  now = 0;

  dt = 0;

  dtStep = 0;

  last = 0;

  step = 1 / 60;

  frames = 0;

  paused = false;

  timestamp = function() {
    return window.performance.now();
  };

  frame = function() {
    frames = 0;
    now = timestamp();
    dt = dt + Math.min(1, (now - last) / 1000);
    dtStep = dt;
    while (dtStep > step) {
      dtStep = dtStep - step;
      frames++;
      fixedUpdate(step);
    }
    update(dt);
    render(dtStep);
    last = now;
    if (!paused) {
      requestAnimationFrame(frame);
    }
    return null;
  };

  beginGameLoop = function() {
    createGameObjects();
    awake();
    start();
    last = timestamp();
    requestAnimationFrame(frame);
    return true;
  };


  /*
  --------------------------------------------
       Begin _KeyCode.coffee
  --------------------------------------------
   */

  KeyCode = {
    A: 65,
    B: 66,
    C: 67,
    D: 68,
    E: 69,
    F: 70,
    G: 71,
    H: 72,
    I: 73,
    J: 74,
    K: 75,
    L: 76,
    M: 77,
    N: 78,
    O: 79,
    P: 80,
    Q: 81,
    R: 82,
    S: 83,
    T: 84,
    U: 85,
    V: 86,
    W: 87,
    X: 88,
    Y: 89,
    Z: 90,
    Zero: 48,
    One: 49,
    Two: 50,
    Three: 51,
    Four: 52,
    Five: 53,
    Six: 54,
    Seven: 55,
    Eight: 56,
    Nine: 57,
    Space: 32,
    Tab: 9,
    Delete: 8,
    Enter: 13,
    Shift: 16,
    Left: 37,
    Up: 38,
    Right: 39,
    Down: 40
  };


  /*
  --------------------------------------------
       Begin _game-object.coffee
  --------------------------------------------
   */

  GameObject = (function() {
    var collidedObjects, collisionGroup, enabled, height, id, name, width, x, y;

    name = null;

    x = null;

    y = null;

    width = null;

    height = null;

    id = null;

    enabled = null;

    collisionGroup = null;

    collidedObjects = null;

    function GameObject(name) {
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.fixedUpdate = __bind(this.fixedUpdate, this);
      this.start = __bind(this.start, this);
      this.awake = __bind(this.awake, this);
      this.enabled = true;
      this.collisionGroup = "default";
      this.name = name;
      this.x = 0;
      this.y = 0;
      this.width = 0;
      this.height = 0;
      this.collidedObjects = [];
      this.id = gameObjects.length;
      gameObjects.push(this);
    }

    GameObject.prototype.awake = function() {};

    GameObject.prototype.start = function() {};

    GameObject.prototype.fixedUpdate = function(step) {};

    GameObject.prototype.update = function(dt) {};

    GameObject.prototype.render = function(dt) {};

    GameObject.prototype.onKeyDown = function(key) {};

    GameObject.prototype.onKeyUp = function(key) {};

    GameObject.prototype.onCollisionEnter = function(other) {};

    GameObject.prototype.onCollisionExit = function(other) {};

    return GameObject;

  })();


  /*
  --------------------------------------------
       Begin _input-handling.coffee
  --------------------------------------------
   */

  $(function() {
    $(window).on('keydown', function(e) {
      var o, _i, _len;
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          o.onKeyDown(e.which);
        }
      }
      return null;
    });
    return $(window).on('keyup', function(e) {
      var o, _i, _len;
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          o.onKeyUp(e.which);
        }
      }
      return null;
    });
  });


  /*
  --------------------------------------------
       Begin _engine.coffee
  --------------------------------------------
   */

  canvas = null;

  context = null;

  gameObjects = [];

  $(function() {
    canvas = document.getElementsByTagName('canvas')[0];
    context = canvas.getContext('2d');
    return beginGameLoop();
  });


  /*
  --------------------------------------------
       Begin _game-loop-codebot.coffee
  --------------------------------------------
   */

  createGameObjects = function() {
    var r1;
    r1 = new Robot("Robot 1");
    return null;
  };

  awake = function() {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.awake();
      }
    }
    return null;
  };

  start = function() {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.start();
      }
    }
    return null;
  };

  update = function(dt) {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.update(dt);
      }
    }
    return null;
  };

  fixedUpdate = function(step) {
    var o1, oldCollide, _i, _len;
    oldCollide = false;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o1 = gameObjects[_i];
      if (o1.enabled) {
        o1.fixedUpdate(step);
      }
    }
    return null;
  };

  render = function(dt) {
    var o, _i, _len;
    context.save();
    context.setTransform(1, 0, 0, 1, 0, 0);
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.restore();
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.render(dt);
      }
    }
    return null;
  };


  /*
  --------------------------------------------
       Begin _codebot-object.coffee
  --------------------------------------------
   */


  /*
  
  This gives some standardized methods/variables
  that are universal throughout codebot objects
   */

  CodebotGameObject = (function(_super) {
    var center, color, getInfo, height, keysPressed, width;

    __extends(CodebotGameObject, _super);

    width = null;

    height = null;

    color = null;

    keysPressed = null;

    center = null;

    function CodebotGameObject(name) {
      this.drawSelf = __bind(this.drawSelf, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      var i, _i;
      CodebotGameObject.__super__.constructor.call(this, name);
      this.color = '#000';
      this.width = 0;
      this.height = 0;
      this.keysPressed = [];
      for (i = _i = 1; _i <= 100; i = ++_i) {
        this.keysPressed[i] = false;
      }
      this.collisionGroup = "codebot";
      this.center = {
        x: this.x + (0.5 * this.width),
        y: this.y + (0.5 * this.height)
      };
    }

    CodebotGameObject.prototype.awake = function() {
      return CodebotGameObject.__super__.awake.apply(this, arguments);
    };

    CodebotGameObject.prototype.update = function(dt) {
      CodebotGameObject.__super__.update.call(this, dt);
      return this.center = {
        x: this.x + (0.5 * this.width),
        y: this.y + (0.5 * this.height)
      };
    };

    CodebotGameObject.prototype.render = function(dt) {
      return CodebotGameObject.__super__.render.call(this, dt);
    };

    CodebotGameObject.prototype.onCollisionEnter = function(other) {
      return CodebotGameObject.__super__.onCollisionEnter.call(this, other);
    };

    CodebotGameObject.prototype.onCollisionExit = function(other) {
      return CodebotGameObject.__super__.onCollisionExit.call(this, other);
    };

    CodebotGameObject.prototype.onKeyDown = function(key) {
      return this.keysPressed[key] = true;
    };

    CodebotGameObject.prototype.onKeyUp = function(key) {
      return this.keysPressed[key] = false;
    };

    CodebotGameObject.prototype.drawSelf = function() {
      return drawSquare(this.x, this.y, this.width, this.height, this.color);
    };

    getInfo = function() {
      return {
        name: CodebotGameObject.name,
        x: CodebotGameObject.x,
        y: CodebotGameObject.y,
        width: CodebotGameObject.width,
        height: CodebotGameObject.height,
        collisionGroup: CodebotGameObject.collisionGroup
      };
    };

    return CodebotGameObject;

  })(GameObject);


  /*
  --------------------------------------------
       Begin _robot-object.coffee
  --------------------------------------------
   */

  Robot = (function(_super) {
    var inCollision, objectsSighted, sightRadius, speed;

    __extends(Robot, _super);

    inCollision = null;

    sightRadius = null;

    objectsSighted = null;

    speed = null;

    function Robot(name) {
      this.stayOnScreen = __bind(this.stayOnScreen, this);
      this.drawSightRadius = __bind(this.drawSightRadius, this);
      this.lookAround = __bind(this.lookAround, this);
      this.moveLeft = __bind(this.moveLeft, this);
      this.moveRight = __bind(this.moveRight, this);
      this.moveDown = __bind(this.moveDown, this);
      this.moveUp = __bind(this.moveUp, this);
      this.takeTurn = __bind(this.takeTurn, this);
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      Robot.__super__.constructor.call(this, name);
      this.color = '#000';
      this.width = 10;
      this.height = 10;
      this.sightRadius = 40;
      this.objectsSighted = [];
      this.collisionGroup = "robot";
      this.speed = 10;
    }

    Robot.prototype.awake = function() {
      Robot.__super__.awake.apply(this, arguments);
      return this.stayOnScreen();
    };

    Robot.prototype.update = function(dt) {
      Robot.__super__.update.call(this, dt);
      if (this.keysPressed[KeyCode.W]) {
        this.moveUp();
        this.keysPressed[KeyCode.W] = false;
      }
      if (this.keysPressed[KeyCode.A]) {
        this.moveLeft();
        this.keysPressed[KeyCode.A] = false;
      }
      if (this.keysPressed[KeyCode.S]) {
        this.moveDown();
        this.keysPressed[KeyCode.S] = false;
      }
      if (this.keysPressed[KeyCode.D]) {
        this.moveRight();
        return this.keysPressed[KeyCode.D] = false;
      }
    };

    Robot.prototype.render = function(dt) {
      this.drawSelf();
      this.drawSightRadius();
      if (this.inCollision) {
        drawPolygon([[this.x - 0.5, this.y - 0.5], [this.x - 0.5, this.y + this.height + 0.5], [this.x + this.width + 0.5, this.y + this.height + 0.5], [this.x + this.width + 0.5, this.y - 0.5]], '#ff0000');
      }
      return Robot.__super__.render.call(this, dt);
    };

    Robot.prototype.onCollisionEnter = function(other) {
      return this.inCollision = true;
    };

    Robot.prototype.onCollisionExit = function(other) {
      var collisionBool, _i, _len, _ref, _results;
      this.inCollision = false;
      _ref = this.collidedObjects;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        collisionBool = _ref[_i];
        if (collisionBool) {
          this.inCollision = true;
          break;
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };


    /*
    	   * takeTurn:
    	   *   called when it is this robot's turn to do something.
    	   *   it can only respond to stuff, so it can't set
    	   *   any variables. But it can call the rest of the methods
    	   *   in this section, and give commands. This can't be
    	   *   automatically enforced using JS, but each robot
    	   *   may only do one "thing" - there will be a code
    	   *   done of each robot before battle, and percieved
    	   *   violations of this rule will be dealt with on a
    	   *   case by case basis. (i.e. the robot might be
    	   *   disqualified and grant an immediate victory to the
    	   *   opponent.
     */

    Robot.prototype.takeTurn = function(roundNumber) {};

    Robot.prototype.moveUp = function() {
      this.y -= this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveDown = function() {
      this.y += this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveRight = function() {
      this.x += this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveLeft = function() {
      this.x -= this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.lookAround = function() {
      var o, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          _results.push(o.render(dt));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Robot.prototype.drawSightRadius = function() {
      return drawCircle(this.center.x, this.center.y, this.sightRadius, '#11aa00', false, 3);
    };

    Robot.prototype.stayOnScreen = function() {
      this.x = Math.min(canvas.width - this.width, Math.max(0, this.x));
      return this.y = Math.min(canvas.height - this.height, Math.max(0, this.y));
    };

    return Robot;

  })(CodebotGameObject);


  /*
  --------------------------------------------
       Begin codebot-ck-sourcemap-source.coffee
  --------------------------------------------
   */


  /*
  --------------------------------------------
       Begin _debug.coffee
  --------------------------------------------
   */

  Debug = {
    getTime: function() {
      now = new Date();
      return now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
    },
    Log: function(txt) {
      var oldHtml;
      oldHtml = $('#debug').html();
      if (oldHtml !== '') {
        oldHtml = oldHtml + '<br/>';
      }
      return $('#debug').html(oldHtml + this.getTime() + ' - ' + txt);
    }
  };


  /*
  --------------------------------------------
       Begin _drawing-functions.coffee
  --------------------------------------------
   */

  drawSquare = function(x, y, w, h, color) {
    if (color == null) {
      color = '#000000';
    }
    context.fillStyle = color;
    context.fillRect(x, y, w, h);
    return null;
  };

  drawLine = function(x1, y1, x2, y2, color) {
    if (color == null) {
      color = '#000000';
    }
    context.beginPath();
    context.moveTo(x1, y1);
    context.lineTo(x2, y2);
    context.strokeStyle = color;
    context.stroke();
    return null;
  };

  drawPolygon = function(vertexArray, color) {
    var firstVertex, vertex, _i, _len;
    if (color == null) {
      color = '#000000';
    }
    context.beginPath();
    firstVertex = vertexArray[0];
    context.moveTo(firstVertex[0], firstVertex[1]);
    for (_i = 0, _len = vertexArray.length; _i < _len; _i++) {
      vertex = vertexArray[_i];
      context.lineTo(vertex[0], vertex[1]);
    }
    context.lineTo(firstVertex[0], firstVertex[1]);
    context.strokeStyle = color;
    return context.stroke();
  };

  drawText = function(txt, x, y) {
    return context.fillText(txt, x, y);
  };

  drawCircle = function(x, y, radius, color, fill, lineWidth) {
    if (color == null) {
      color = '#000000';
    }
    if (fill == null) {
      fill = false;
    }
    if (lineWidth == null) {
      lineWidth = 1;
    }
    context.beginPath();
    context.arc(x, y, radius, (Math.PI / 180) * 0, (Math.PI / 180) * 360, true);
    if (fill) {
      context.fillStyle = color;
      context.fill();
    } else {
      context.lineWidth = lineWidth;
      context.strokeStyle = color;
      context.stroke();
    }
    return context.closePath();
  };


  /*
  --------------------------------------------
       Begin _game-loop-bootstrap.coffee
  --------------------------------------------
   */

  now = 0;

  dt = 0;

  dtStep = 0;

  last = 0;

  step = 1 / 60;

  frames = 0;

  paused = false;

  timestamp = function() {
    return window.performance.now();
  };

  frame = function() {
    frames = 0;
    now = timestamp();
    dt = dt + Math.min(1, (now - last) / 1000);
    dtStep = dt;
    while (dtStep > step) {
      dtStep = dtStep - step;
      frames++;
      fixedUpdate(step);
    }
    update(dt);
    render(dtStep);
    last = now;
    if (!paused) {
      requestAnimationFrame(frame);
    }
    return null;
  };

  beginGameLoop = function() {
    createGameObjects();
    awake();
    start();
    last = timestamp();
    requestAnimationFrame(frame);
    return true;
  };


  /*
  --------------------------------------------
       Begin _KeyCode.coffee
  --------------------------------------------
   */

  KeyCode = {
    A: 65,
    B: 66,
    C: 67,
    D: 68,
    E: 69,
    F: 70,
    G: 71,
    H: 72,
    I: 73,
    J: 74,
    K: 75,
    L: 76,
    M: 77,
    N: 78,
    O: 79,
    P: 80,
    Q: 81,
    R: 82,
    S: 83,
    T: 84,
    U: 85,
    V: 86,
    W: 87,
    X: 88,
    Y: 89,
    Z: 90,
    Zero: 48,
    One: 49,
    Two: 50,
    Three: 51,
    Four: 52,
    Five: 53,
    Six: 54,
    Seven: 55,
    Eight: 56,
    Nine: 57,
    Space: 32,
    Tab: 9,
    Delete: 8,
    Enter: 13,
    Shift: 16,
    Left: 37,
    Up: 38,
    Right: 39,
    Down: 40
  };


  /*
  --------------------------------------------
       Begin _game-object.coffee
  --------------------------------------------
   */

  GameObject = (function() {
    var collidedObjects, collisionGroup, enabled, height, id, name, width, x, y;

    name = null;

    x = null;

    y = null;

    width = null;

    height = null;

    id = null;

    enabled = null;

    collisionGroup = null;

    collidedObjects = null;

    function GameObject(name) {
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.fixedUpdate = __bind(this.fixedUpdate, this);
      this.start = __bind(this.start, this);
      this.awake = __bind(this.awake, this);
      this.enabled = true;
      this.collisionGroup = "default";
      this.name = name;
      this.x = 0;
      this.y = 0;
      this.width = 0;
      this.height = 0;
      this.collidedObjects = [];
      this.id = gameObjects.length;
      gameObjects.push(this);
    }

    GameObject.prototype.awake = function() {};

    GameObject.prototype.start = function() {};

    GameObject.prototype.fixedUpdate = function(step) {};

    GameObject.prototype.update = function(dt) {};

    GameObject.prototype.render = function(dt) {};

    GameObject.prototype.onKeyDown = function(key) {};

    GameObject.prototype.onKeyUp = function(key) {};

    GameObject.prototype.onCollisionEnter = function(other) {};

    GameObject.prototype.onCollisionExit = function(other) {};

    return GameObject;

  })();


  /*
  --------------------------------------------
       Begin _input-handling.coffee
  --------------------------------------------
   */

  $(function() {
    $(window).on('keydown', function(e) {
      var o, _i, _len;
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          o.onKeyDown(e.which);
        }
      }
      return null;
    });
    return $(window).on('keyup', function(e) {
      var o, _i, _len;
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          o.onKeyUp(e.which);
        }
      }
      return null;
    });
  });


  /*
  --------------------------------------------
       Begin _engine.coffee
  --------------------------------------------
   */

  canvas = null;

  context = null;

  gameObjects = [];

  $(function() {
    canvas = document.getElementsByTagName('canvas')[0];
    context = canvas.getContext('2d');
    return beginGameLoop();
  });


  /*
  --------------------------------------------
       Begin _game-loop-codebot.coffee
  --------------------------------------------
   */

  createGameObjects = function() {
    var r1;
    r1 = new Robot("Robot 1");
    return null;
  };

  awake = function() {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.awake();
      }
    }
    return null;
  };

  start = function() {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.start();
      }
    }
    return null;
  };

  update = function(dt) {
    var o, _i, _len;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.update(dt);
      }
    }
    return null;
  };

  fixedUpdate = function(step) {
    var o1, oldCollide, _i, _len;
    oldCollide = false;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o1 = gameObjects[_i];
      if (o1.enabled) {
        o1.fixedUpdate(step);
      }
    }
    return null;
  };

  render = function(dt) {
    var o, _i, _len;
    context.save();
    context.setTransform(1, 0, 0, 1, 0, 0);
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.restore();
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o = gameObjects[_i];
      if (o.enabled) {
        o.render(dt);
      }
    }
    return null;
  };


  /*
  --------------------------------------------
       Begin _codebot-object.coffee
  --------------------------------------------
   */


  /*
  
  This gives some standardized methods/variables
  that are universal throughout codebot objects
   */

  CodebotGameObject = (function(_super) {
    var center, color, getInfo, height, keysPressed, width;

    __extends(CodebotGameObject, _super);

    width = null;

    height = null;

    color = null;

    keysPressed = null;

    center = null;

    function CodebotGameObject(name) {
      this.drawSelf = __bind(this.drawSelf, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      var i, _i;
      CodebotGameObject.__super__.constructor.call(this, name);
      this.color = '#000';
      this.width = 0;
      this.height = 0;
      this.keysPressed = [];
      for (i = _i = 1; _i <= 100; i = ++_i) {
        this.keysPressed[i] = false;
      }
      this.collisionGroup = "codebot";
      this.center = {
        x: this.x + (0.5 * this.width),
        y: this.y + (0.5 * this.height)
      };
    }

    CodebotGameObject.prototype.awake = function() {
      return CodebotGameObject.__super__.awake.apply(this, arguments);
    };

    CodebotGameObject.prototype.update = function(dt) {
      CodebotGameObject.__super__.update.call(this, dt);
      return this.center = {
        x: this.x + (0.5 * this.width),
        y: this.y + (0.5 * this.height)
      };
    };

    CodebotGameObject.prototype.render = function(dt) {
      return CodebotGameObject.__super__.render.call(this, dt);
    };

    CodebotGameObject.prototype.onCollisionEnter = function(other) {
      return CodebotGameObject.__super__.onCollisionEnter.call(this, other);
    };

    CodebotGameObject.prototype.onCollisionExit = function(other) {
      return CodebotGameObject.__super__.onCollisionExit.call(this, other);
    };

    CodebotGameObject.prototype.onKeyDown = function(key) {
      return this.keysPressed[key] = true;
    };

    CodebotGameObject.prototype.onKeyUp = function(key) {
      return this.keysPressed[key] = false;
    };

    CodebotGameObject.prototype.drawSelf = function() {
      return drawSquare(this.x, this.y, this.width, this.height, this.color);
    };

    getInfo = function() {
      return {
        name: CodebotGameObject.name,
        x: CodebotGameObject.x,
        y: CodebotGameObject.y,
        width: CodebotGameObject.width,
        height: CodebotGameObject.height,
        collisionGroup: CodebotGameObject.collisionGroup
      };
    };

    return CodebotGameObject;

  })(GameObject);


  /*
  --------------------------------------------
       Begin _robot-object.coffee
  --------------------------------------------
   */

  Robot = (function(_super) {
    var inCollision, objectsSighted, sightRadius, speed;

    __extends(Robot, _super);

    inCollision = null;

    sightRadius = null;

    objectsSighted = null;

    speed = null;

    function Robot(name) {
      this.stayOnScreen = __bind(this.stayOnScreen, this);
      this.drawSightRadius = __bind(this.drawSightRadius, this);
      this.lookAround = __bind(this.lookAround, this);
      this.moveLeft = __bind(this.moveLeft, this);
      this.moveRight = __bind(this.moveRight, this);
      this.moveDown = __bind(this.moveDown, this);
      this.moveUp = __bind(this.moveUp, this);
      this.takeTurn = __bind(this.takeTurn, this);
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      Robot.__super__.constructor.call(this, name);
      this.color = '#000';
      this.width = 10;
      this.height = 10;
      this.sightRadius = 40;
      this.objectsSighted = [];
      this.collisionGroup = "robot";
      this.speed = 10;
    }

    Robot.prototype.awake = function() {
      Robot.__super__.awake.apply(this, arguments);
      return this.stayOnScreen();
    };

    Robot.prototype.update = function(dt) {
      Robot.__super__.update.call(this, dt);
      if (this.keysPressed[KeyCode.W]) {
        this.moveUp();
        this.keysPressed[KeyCode.W] = false;
      }
      if (this.keysPressed[KeyCode.A]) {
        this.moveLeft();
        this.keysPressed[KeyCode.A] = false;
      }
      if (this.keysPressed[KeyCode.S]) {
        this.moveDown();
        this.keysPressed[KeyCode.S] = false;
      }
      if (this.keysPressed[KeyCode.D]) {
        this.moveRight();
        return this.keysPressed[KeyCode.D] = false;
      }
    };

    Robot.prototype.render = function(dt) {
      this.drawSelf();
      this.drawSightRadius();
      if (this.inCollision) {
        drawPolygon([[this.x - 0.5, this.y - 0.5], [this.x - 0.5, this.y + this.height + 0.5], [this.x + this.width + 0.5, this.y + this.height + 0.5], [this.x + this.width + 0.5, this.y - 0.5]], '#ff0000');
      }
      return Robot.__super__.render.call(this, dt);
    };

    Robot.prototype.onCollisionEnter = function(other) {
      return this.inCollision = true;
    };

    Robot.prototype.onCollisionExit = function(other) {
      var collisionBool, _i, _len, _ref, _results;
      this.inCollision = false;
      _ref = this.collidedObjects;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        collisionBool = _ref[_i];
        if (collisionBool) {
          this.inCollision = true;
          break;
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };


    /*
    	   * takeTurn:
    	   *   called when it is this robot's turn to do something.
    	   *   it can only respond to stuff, so it can't set
    	   *   any variables. But it can call the rest of the methods
    	   *   in this section, and give commands. This can't be
    	   *   automatically enforced using JS, but each robot
    	   *   may only do one "thing" - there will be a code
    	   *   done of each robot before battle, and percieved
    	   *   violations of this rule will be dealt with on a
    	   *   case by case basis. (i.e. the robot might be
    	   *   disqualified and grant an immediate victory to the
    	   *   opponent.
     */

    Robot.prototype.takeTurn = function(roundNumber) {};

    Robot.prototype.moveUp = function() {
      this.y -= this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveDown = function() {
      this.y += this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveRight = function() {
      this.x += this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.moveLeft = function() {
      this.x -= this.speed;
      return this.stayOnScreen();
    };

    Robot.prototype.lookAround = function() {
      var o, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
        o = gameObjects[_i];
        if (o.enabled) {
          _results.push(o.render(dt));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Robot.prototype.drawSightRadius = function() {
      return drawCircle(this.center.x, this.center.y, this.sightRadius, '#11aa00', false, 3);
    };

    Robot.prototype.stayOnScreen = function() {
      this.x = Math.min(canvas.width - this.width, Math.max(0, this.x));
      return this.y = Math.min(canvas.height - this.height, Math.max(0, this.y));
    };

    return Robot;

  })(CodebotGameObject);


  /*
  --------------------------------------------
       Begin codebot.coffee
  --------------------------------------------
   */

}).call(this);
