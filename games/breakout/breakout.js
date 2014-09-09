// Generated by CoffeeScript 1.8.0
(function() {
  var Ball, Brick, Debug, GameController, GameObject, KeyCode, Player, awake, beginGameLoop, canvas, context, createGameObjects, drawCircle, drawLine, drawPolygon, drawSquare, drawText, dt, dtStep, fixedUpdate, frame, frames, gameController, gameObjects, gameStarted, last, now, numberOfBricks, paused, render, start, step, timestamp, update,
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

  drawText = function(x, y, txt) {
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
      context.lineWidth = 1;
    }
    return context.closePath();
  };

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
    var gameStarted;
    createGameObjects();
    awake();
    start();
    gameStarted = true;
    last = timestamp();
    requestAnimationFrame(frame);
    return true;
  };

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
      this.enabled = this.enabled || true;
      this.collisionGroup = this.collisionGroup || "default";
      this.name = name;
      this.x = this.x || 0;
      this.y = this.y || 0;
      this.width = this.width || 0;
      this.height = this.height || 0;
      this.collidedObjects = this.collidedObjects || [];
      this.id = gameObjects.length;
      gameObjects.push(this);
      if (gameStarted) {
        this.awake();
        this.start();
      }
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

  canvas = null;

  context = null;

  gameStarted = false;

  gameObjects = [];

  $(function() {
    canvas = document.getElementsByTagName('canvas')[0];
    context = canvas.getContext('2d');
    return beginGameLoop();
  });

  gameController = null;

  numberOfBricks = null;

  createGameObjects = function() {
    numberOfBricks = 0;
    gameController = new GameController('game controller');
    Debug.Log('created objects');
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
    var newCollide, o1, o2, oldCollide, _i, _j, _len, _len1;
    oldCollide = false;
    for (_i = 0, _len = gameObjects.length; _i < _len; _i++) {
      o1 = gameObjects[_i];
      if (o1.enabled && o1.collisionGroup === 'ball') {
        o1.fixedUpdate(step);
        for (_j = 0, _len1 = gameObjects.length; _j < _len1; _j++) {
          o2 = gameObjects[_j];
          oldCollide = false;
          newCollide = false;
          if (o1.collidedObjects[o2.id]) {
            oldCollide = true;
          }
          if (o2.enabled && o1 !== o2) {
            if (o1.x >= o2.x && o1.x <= o2.x + o2.width && o1.y >= o2.y && o1.y <= o2.y + o2.height) {
              newCollide = true;
              if (!oldCollide) {
                o1.onCollisionEnter(o2);
              }
            }
          }
          if (oldCollide && !newCollide) {
            o1.onCollisionExit(o2);
          }
          o1.collidedObjects[o2.id] = newCollide;
        }
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

  GameController = (function(_super) {
    var score;

    __extends(GameController, _super);

    score = null;

    function GameController(name) {
      this.reset = __bind(this.reset, this);
      this.addScore = __bind(this.addScore, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.start = __bind(this.start, this);
      this.awake = __bind(this.awake, this);
      this.collisionGroup = 'controller';
      GameController.__super__.constructor.call(this, name);
    }

    GameController.prototype.awake = function() {
      return GameController.__super__.awake.apply(this, arguments);
    };

    GameController.prototype.start = function() {
      return GameController.__super__.start.apply(this, arguments);
    };

    GameController.prototype.update = function(dt) {
      if (numberOfBricks === 0) {
        console.log('No bricks - resetting');
        this.reset();
      }
      return GameController.__super__.update.call(this, dt);
    };

    GameController.prototype.render = function(dt) {
      context.fillStyle = '#000';
      context.font = '100 16px sans-serif';
      drawText(15, 15, 'Score: ' + this.score);
      return GameController.__super__.render.call(this, dt);
    };

    GameController.prototype.addScore = function(n) {
      return this.score += n;
    };

    GameController.prototype.reset = function() {
      var bHei, bWid, ball, brick, p1, xx, yy, _i, _j, _ref;
      this.score = 0;
      gameObjects = [this];
      p1 = new Player("P1");
      p1.keyUp = KeyCode.W;
      p1.keyLeft = KeyCode.A;
      p1.keyRight = KeyCode.D;
      p1.keyDown = KeyCode.S;
      p1.color = "#badcab";
      p1.awake();
      console.log(p1);
      bWid = 32;
      bHei = 16;
      for (xx = _i = 0, _ref = Math.floor((canvas.width - bWid) / bWid); 0 <= _ref ? _i <= _ref : _i >= _ref; xx = 0 <= _ref ? ++_i : --_i) {
        for (yy = _j = 1; _j <= 5; yy = ++_j) {
          brick = new Brick('Brick ' + xx + '-' + yy);
          brick.width = bWid;
          brick.height = bHei;
          brick.x = xx * brick.width + 5;
          brick.y = yy * brick.height;
        }
      }
      return ball = new Ball("ball");
    };

    return GameController;

  })(GameObject);

  Brick = (function(_super) {
    var color;

    __extends(Brick, _super);

    color = null;

    function Brick(name) {
      this.destroy = __bind(this.destroy, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      this.color = '#abc123';
      this.collisionGroup = 'brick';
      numberOfBricks += 1;
      Brick.__super__.constructor.call(this, name);
    }

    Brick.prototype.awake = function() {
      return Brick.__super__.awake.apply(this, arguments);
    };

    Brick.prototype.update = function(dt) {
      return Brick.__super__.update.call(this, dt);
    };

    Brick.prototype.render = function(dt) {
      drawSquare(this.x, this.y, this.width, this.height, '#000');
      drawSquare(this.x + 1, this.y + 1, this.width - 2, this.height - 2, this.color);
      return Brick.__super__.render.call(this, dt);
    };

    Brick.prototype.destroy = function() {
      gameController.addScore(100);
      numberOfBricks -= 1;
      return this.enabled = false;
    };

    return Brick;

  })(GameObject);

  Player = (function(_super) {
    var color, hp, inCollision, keyDown, keyLeft, keyRight, keyUp, keysPressed, maxHealth, speed;

    __extends(Player, _super);

    color = null;

    maxHealth = null;

    hp = null;

    keyUp = null;

    keyDown = null;

    keyLeft = null;

    keyRight = null;

    keysPressed = null;

    inCollision = null;

    speed = null;

    function Player(name) {
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.awake = __bind(this.awake, this);
      var i, _i;
      Player.__super__.constructor.call(this, name);
      this.color = "#000000";
      this.maxHealth = 10;
      this.hp = this.maxHealth;
      this.keysPressed = [];
      for (i = _i = 1; _i <= 100; i = ++_i) {
        this.keysPressed[i] = false;
      }
      this.collisionGroup = "player";
      this.inCollision = false;
      this.speed = 2;
    }

    Player.prototype.awake = function() {
      this.width = 64;
      this.height = 16;
      this.x = canvas.width / 2;
      this.y = canvas.height - 2 * this.height;
      this.keyUp = KeyCode.W;
      this.keyLeft = KeyCode.A;
      this.keyDown = KeyCode.S;
      this.keyRight = KeyCode.D;
      return Player.__super__.awake.apply(this, arguments);
    };

    Player.prototype.update = function(dt) {
      var hor, ver;
      hor = 0;
      ver = 0;
      if (this.keysPressed[this.keyRight]) {
        hor += 1;
      }
      if (this.keysPressed[this.keyLeft]) {
        hor -= 1;
      }
      this.x += hor * this.speed;
      this.x = Math.max(0, Math.min(canvas.width - this.width, this.x));
      return Player.__super__.update.call(this, dt);
    };

    Player.prototype.render = function(dt) {
      drawSquare(this.x, this.y, this.width, this.height, this.color);
      return Player.__super__.render.call(this, dt);
    };

    Player.prototype.onKeyDown = function(key) {
      return this.keysPressed[key] = true;
    };

    Player.prototype.onKeyUp = function(key) {
      return this.keysPressed[key] = false;
    };

    Player.prototype.onCollisionEnter = function(other) {
      return this.inCollision = true;
    };

    Player.prototype.onCollisionExit = function(other) {
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

    return Player;

  })(GameObject);

  Ball = (function(_super) {
    var lastPositions, velocity;

    __extends(Ball, _super);

    velocity = null;

    lastPositions = null;

    function Ball(name) {
      this.onCollisionExit = __bind(this.onCollisionExit, this);
      this.onCollisionEnter = __bind(this.onCollisionEnter, this);
      this.onKeyUp = __bind(this.onKeyUp, this);
      this.onKeyDown = __bind(this.onKeyDown, this);
      this.render = __bind(this.render, this);
      this.update = __bind(this.update, this);
      this.fixedUpdate = __bind(this.fixedUpdate, this);
      this.start = __bind(this.start, this);
      this.awake = __bind(this.awake, this);
      Ball.__super__.constructor.call(this, name);
      this.collisionGroup = "ball";
      this.velocity = {
        x: 2,
        y: -2
      };
      this.name = name;
      this.x = canvas.width / 2;
      this.y = canvas.height - 50;
      this.width = 4;
      this.height = 4;
      this.color = "#000011";
      lastPositions = [];
    }

    Ball.prototype.awake = function() {};

    Ball.prototype.start = function() {};

    Ball.prototype.fixedUpdate = function(step) {};

    Ball.prototype.update = function(dt) {
      lastPositions.unshift({
        x: this.x,
        y: this.y
      });
      if (lastPositions.length > 100) {
        lastPositions.pop();
      }
      this.x += this.velocity.x;
      this.y += this.velocity.y;
      if (this.x > canvas.width || this.x < 0) {
        this.velocity.x = -1 * this.velocity.x;
        this.x = Math.min(canvas.width, Math.max(0, this.x));
      }
      if (this.y < 0) {
        this.velocity.y = -1 * this.velocity.y;
        this.y = Math.min(canvas.height, Math.max(0, this.y));
      }
      if (this.y > canvas.height) {
        return gameController.reset();
      }
    };

    Ball.prototype.render = function(dt) {
      var i, pos, _i, _len;
      drawSquare(this.x, this.y, this.width, this.height, this.color);
      for (i = _i = 0, _len = lastPositions.length; _i < _len; i = ++_i) {
        pos = lastPositions[i];
        drawSquare(pos.x, pos.y, this.width, this.height, "rgba(0,0,0," + ((lastPositions.length - i) / lastPositions.length) + ")");
      }
      return null;
    };

    Ball.prototype.onKeyDown = function(key) {};

    Ball.prototype.onKeyUp = function(key) {};

    Ball.prototype.onCollisionEnter = function(other) {
      var angle, anglesOther, center, centerOther, collisionSide, debugText, halfSize, halfSizeOther, horizCollision, piFourths, vertCollision;
      horizCollision = false;
      vertCollision = false;
      if (other.collisionGroup === 'player' || other.collisionGroup === 'brick') {
        halfSize = {
          width: 0.5 * this.width,
          height: 0.5 * this.height
        };
        halfSizeOther = {
          width: 0.5 * other.width,
          height: 0.5 * other.height
        };
        center = {
          x: this.x + halfSize.width,
          y: this.y + halfSize.height
        };
        centerOther = {
          x: other.x + halfSizeOther.width,
          y: other.y + halfSizeOther.height
        };
        anglesOther = {
          topLeft: Math.atan2(halfSizeOther.height, -1 * halfSizeOther.width),
          topRight: Math.atan2(halfSizeOther.height, halfSizeOther.width),
          bottomRight: Math.atan2(-1 * halfSizeOther.height, halfSizeOther.width),
          bottomLeft: Math.atan2(-1 * halfSizeOther.height, -1 * halfSizeOther.width)
        };
        console.log(anglesOther);
        debugText = 'Collision: ' + this.name + ' <-> ' + other.name + ' ';
        collisionSide = '';
        angle = Math.atan2(centerOther.y - center.y, centerOther.x - center.x);
        debugText += '...angle: ' + angle + ' ';
        piFourths = 0.25 * Math.PI;
        if (angle >= anglesOther.bottomRight && angle < anglesOther.topRight) {
          horizCollision = true;
          debugText += '...on right ';
          collisionSide = 'right';
        } else if (angle >= anglesOther.topRight && angle < anglesOther.topLeft) {
          vertCollision = true;
          debugText += '...on top ';
          collisionSide = 'top';
        } else if (angle >= anglesOther.bottomLeft && angle < anglesOther.bottomRight) {
          vertCollision = true;
          debugText += '...on bottom ';
          collisionSide = 'bottom';
        } else if (angle >= anglesOther.topLeft || angle < anglesOther.bottomLeft) {
          horizCollision = true;
          debugText += '...on left ';
          collisionSide = 'left';
        }
        console.log(debugText);
        if (horizCollision) {
          this.velocity.x *= -1;
        }
        if (vertCollision) {
          this.velocity.y *= -1;
        }
      }
      if (other.collisionGroup === 'brick') {
        other.destroy();
      }
      return null;
    };

    Ball.prototype.onCollisionExit = function(other) {};

    return Ball;

  })(GameObject);

}).call(this);
