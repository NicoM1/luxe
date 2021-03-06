package phoenix.geometry;


import luxe.Log.*;
import luxe.Vector;
import phoenix.Batcher;
import phoenix.geometry.Geometry;

import luxe.options.GeometryOptions.RectangleGeometryOptions;

class RectangleGeometry extends Geometry {

        /** Create a new Rectangle goemetry with given options */
    public function new( ?options : RectangleGeometryOptions ) {

        options.primitive_type = PrimitiveType.lines;

        super(options);

        if(options == null) return;

        var _x : Float = options.x;
        var _y : Float = options.y;
        var _w : Float = options.w;
        var _h : Float = options.h;

        if(options.rect != null) {
            _x = options.rect.x;
            _y = options.rect.y;
            _w = options.rect.w;
            _h = options.rect.h;
        }

            //tl
        add(new Vertex( new Vector( 0, 0 ), color ));
            //tr
        add(new Vertex( new Vector( _w, 0 ), color ));

            //tr
        add(new Vertex( new Vector( _w, 0 ), color ));
            //br
        add(new Vertex( new Vector( _w, _h ), color ));

            //br
        add(new Vertex( new Vector( _w, _h ), color ));
            //bl
        add(new Vertex( new Vector( 0, _h ), color ));

            //bl
        add(new Vertex( new Vector( 0, _h ), color ));
            //tl
        add(new Vertex( new Vector( 0, 0 ), color ));

        immediate = def(options.immediate, false);
        visible = def(options.visible, true);

        transform.pos = transform.pos.set_xy( _x, _y );

            //:todo: these aren't actually needed, 
            //but kept short term in case
        // vertices[0].uv.uv0.set_uv(0,0);
        // vertices[1].uv.uv0.set_uv(1,0);
        // vertices[2].uv.uv0.set_uv(1,0);
        // vertices[3].uv.uv0.set_uv(1,1);
        // vertices[4].uv.uv0.set_uv(1,1);
        // vertices[5].uv.uv0.set_uv(0,1);
        // vertices[6].uv.uv0.set_uv(0,1);
        // vertices[7].uv.uv0.set_uv(0,0);

    } //new

        /** Set the vertices from values */
    public function set_xywh( _x:Float, _y:Float, _w:Float, _h:Float ) {

        if(vertices.length == 0) return;

        vertices[0].pos.set_xy( 0, 0 );
            //tr
        vertices[1].pos.set_xy( _w, 0 );

            //tr
        vertices[2].pos.set_xy( _w, 0 );
            //br
        vertices[3].pos.set_xy( _w, _h );

            //br
        vertices[4].pos.set_xy( _w, _h );
            //bl
        vertices[5].pos.set_xy( 0, _h );

            //bl
        vertices[6].pos.set_xy( 0, _h );
            //tl
        vertices[7].pos.set_xy( 0, 0 );

            //
        transform.pos = transform.pos.set_xy( _x, _y );

    } //set_xywh

        /** Set the vertices based on a rectangle instance */
    public inline function set( _rect:luxe.Rectangle ) {

        set_xywh(_rect.x, _rect.y, _rect.w, _rect.h);

    } //set


} //RectangleGeometry
