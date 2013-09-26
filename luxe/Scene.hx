
package luxe;

import luxe.Input.MouseEvent;


class Scene {

    public var name : String = 'Untitled Scene';
    
    public var entities : Map<String,Entity>;
    public var inited : Bool = false;
    public var started : Bool = false;

    public function new() {
        entities = new Map<String,Entity>();
    }

    public function create<T>(type:Class<T>, ?_name:String='') : T {

        var _temp_name = _name;

        if(_temp_name.length == 0) {
            _temp_name = Luxe.utils.uuid();
        } else {
            _temp_name = _name;
        }

            //create an instance
        var _entity = Type.createInstance( type, [] );
            //cast to entity so we can set its name
        var _e_entity : Entity = cast _entity;
            //apply it!
        _e_entity.name = _temp_name;

            //add it to this scene
        add(_e_entity);

            //entity
        return _entity;
    }

    public function add( entity:Entity ) {
        entities.set( entity.id, entity );
        
        if(inited) {
            entity._init();
        } //inited

        if(started) {
            entity._start();
        } //started

    } //add

    public function remove(entity:Entity) {
        entity._destroy();
        entities.remove( entity.id );
    }

    public function empty() {

        for(entity in entities) {
                //destroy
            entity._destroy();
            entity = null;
                //remove
            entities.remove(entity.id);
        }
        
    }
    
    public function shutdown() {
        destroy();
    }

    public function oninputdown(_name:String, e:Dynamic) {
         for(entity in entities) {
            entity._oninputdown(_name, e);
        }
    } //oninputdown
    public function oninputup(_name:String, e:Dynamic) {
         for(entity in entities) {
            entity._oninputup(_name, e);
        }
    } //oninputup
    public function onmousedown(e:MouseEvent) {
         for(entity in entities) {
            entity._onmousedown(e);
        }
    } //onmousedown
    public function onmouseup(e:MouseEvent) {
         for(entity in entities) {
            entity._onmouseup(e);
        }
    } //onmouseup
    public function onmousemove(e:MouseEvent) {
         for(entity in entities) {
            entity._onmousemove(e);
        }
    } //onmousemove

    public function destroy() {
         for(entity in entities) {
            entity._destroy();
        }
    } //destroy
    public function init() {
        for(entity in entities) {
            entity._init();
        }        
        inited = true;
    } //init
    public function start() {
        for(entity in entities) {
            entity._start();
        }
        started = true;
    } //start
    public function update(dt:Float) {
        for(entity in entities) {
            entity._update(dt);
        }
    } //update
    public function fixed_update() {
        for(entity in entities) {
            entity._fixed_update();
        }
    } //fixed_update

}