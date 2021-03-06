
import luxe.Color;
import luxe.Input;
import luxe.Sprite;
import luxe.Text;
import luxe.utils.Maths;
import luxe.Vector;

class Main extends luxe.Game {

    var waiting : Bool = true;

    var pan_handle : Sprite;
    var pitch_handle : Sprite;
    var volume_handle : Sprite;

    var pitch_text : Text;
    var pan_text : Text;
    var volume_text : Text;

    var dragging : Sprite;

    override function ready() {

            //for this we'll use the promise "all" api which returns a list of the promised values
        var load = snow.api.Promise.all([
            Luxe.audio.create('assets/sound.ogg', 'sound'),
            Luxe.audio.create('assets/ambience.ogg', 'music')
        ]);

        var loading = new Text({
            text: 'loading',
            pos: Luxe.screen.mid,
            align: center,
            align_vertical: center
        });

        load.then(function(_) {

                //go away
            loading.color.tween(2, {a:0}).onComplete(loading.destroy);

                //make the ui
            create_controls();

                //start playing the music
            Luxe.audio.loop('music');

                //set that loading is done
            waiting = false;

        }); //load.then

    } //ready

    function create_controls() {

        var mid = Luxe.screen.mid;

        Luxe.draw.line({
            p0: new Vector(mid.x - 160, mid.y),
            p1: new Vector(mid.x + 160, mid.y)
        });

        Luxe.draw.line({
            p0: new Vector(mid.x - 160, mid.y - 128),
            p1: new Vector(mid.x + 160, mid.y - 128)
        });

        Luxe.draw.line({
            p0: new Vector(128, mid.y - 160),
            p1: new Vector(128, mid.y + 160)
        });

        pan_text = new Text({
            text: 'pan : 0',
            pos: new Vector(mid.x, mid.y - 64),
            align: center,
            point_size: 18
        });

        pitch_text = new Text({
            text: 'pitch : 1',
            pos: new Vector(mid.x, mid.y - 64 - 128),
            align: center,
            point_size: 18
        });

        volume_text = new Text({
            text: 'volume : 1',
            pos: new Vector(128, mid.y - 64 - 160),
            align: center,
            point_size: 18
        });

        pan_handle = new Sprite({
            color:new Color().rgb(0xf6007b),
            pos: mid,
            size: new Vector(32, 32)
        });

        pitch_handle = new Sprite({
            color:new Color().rgb(0xf6007b),
            pos: new Vector(mid.x, mid.y - 128),
            size: new Vector(32, 32)
        });

        volume_handle = new Sprite({
            color:new Color().rgb(0xf6007b),
            pos: new Vector(128, mid.y - 160),
            size: new Vector(32, 32)
        });

    }

    override function onmousedown( e:MouseEvent ) {

        if(dragging != null) return;

        if(pan_handle.point_inside(e.pos)) {
            dragging = pan_handle;
        } else if(pitch_handle.point_inside(e.pos)) {
            dragging = pitch_handle;
        } else if(volume_handle.point_inside(e.pos)) {
            dragging = volume_handle;
        }

    }

    override function onmousemove( e:MouseEvent ) {

        if(dragging != null) {

            var mid = Luxe.screen.mid;

            if(dragging == pan_handle || dragging == pitch_handle) {

                var left = mid.x-160;
                var right = mid.x+160;

                var amount = e.pos.x;
                    amount = Maths.clamp(amount, left, right);

                    //0 ~ 1
                var normalized_amount = Maths.fixed((amount - left) / 320, 2);

                if(dragging == pan_handle) {

                        //0 ~ 2
                    var pan_amount = normalized_amount * 2;
                        //-1 ~ 1
                        pan_amount -= 1;

                    pan_text.text = 'pan: $pan_amount';
                    pan_handle.pos.x = amount;

                    Luxe.audio.pan('music', pan_amount);
                    Luxe.audio.pan('sound', pan_amount);

                } else if(dragging == pitch_handle) {

                        //0 ~ 1
                    var pitch_amount = normalized_amount;
                        //0.5 ~ 1.5
                        pitch_amount += 0.5;

                    pitch_text.text = 'pitch: $pitch_amount';
                    pitch_handle.pos.x = amount;

                    Luxe.audio.pitch('music', pitch_amount);
                    Luxe.audio.pitch('sound', pitch_amount);

                }

            } else if(dragging == volume_handle) {

                var max = mid.y-160;
                var min = mid.y+160;

                var amount = e.pos.y;
                    amount = Maths.clamp(amount, max, min);

                var volume_amount = 1.0 - Maths.fixed((amount - max) / 320, 2);

                volume_text.text = 'volume: $volume_amount';

                Luxe.audio.volume('music', volume_amount);
                Luxe.audio.volume('sound', volume_amount);

                volume_handle.pos.y = amount;

            }

        } //dragging != null

    } //onmousemove

    override function onmouseup( e:MouseEvent ) {

        if(waiting) return;

        dragging = null;

        if(e.button == MouseButton.right) {
            Luxe.audio.play('sound');
        }

    }

    override function onkeyup( e:KeyEvent ) {

        if(waiting) return;

        if(e.keycode == Key.key_r) {
            Luxe.audio.position('music', 0);
        }

        if(e.keycode == Key.key_l) {
            Luxe.audio.loop('music');
        }

        if(e.keycode == Key.key_s) {
            Luxe.audio.stop('music');
        }
        if(e.keycode == Key.key_p) {
            Luxe.audio.toggle('music');
        }

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup


} //Main
