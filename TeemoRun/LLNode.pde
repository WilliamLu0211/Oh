public class LLNode<T> {

    private T _cargo;    //cargo may only be of type T
    private LLNode<T> _nextNode; //pointer to next LLNode


    // constructor -- initializes instance vars
    public LLNode( T value, LLNode<T> next ) {
        _cargo = value;
        _nextNode = next;
    }


    //--------------v  ACCESSORS  v--------------
    public T getValue() { return _cargo; }

    public LLNode<T> getNext() { return _nextNode; }
    //--------------^  ACCESSORS  ^--------------


    //--------------v  MUTATORS  v--------------
    public T setValue( T newCargo ) {
	      T foo = getValue();
        _cargo = newCargo;
        return foo;
    }

    public LLNode<T> setNext( LLNode<T> newNext ) {
        LLNode<T> foo = getNext();
        _nextNode = newNext;
        return foo;
    }
    //--------------^  MUTATORS  ^--------------

}//end class LLNode
