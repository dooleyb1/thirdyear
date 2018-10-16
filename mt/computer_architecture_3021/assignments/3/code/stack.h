// Written for the following code https://www.geeksforgeeks.org/stack-data-structure-introduction-program/

struct Stack
{
    int top;
    unsigned capacity;
    int* array;
};

extern struct Stack* createStack(unsigned capacity);
extern int pop(struct Stack* stack);
extern void push(struct Stack* stack, int id);
