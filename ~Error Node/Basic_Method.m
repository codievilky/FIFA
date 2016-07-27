function Error_Node=Basic_Method(Node_Alpha,weight)
[Number,~] = size(weight);
x=0.04;
proportion=Node_Alpha+rand*x*2-x;
Error_Node=calculate_error_node(Number,weight,proportion);