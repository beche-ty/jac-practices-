# 
obj Rectangle{
    has width:float;
    has height:float;
    
    def area ->float{
        return self.width *self.height;
        }

    def perimeter ->float{
        return 2*(self.width + self.height);
        }
}

with entry{
    rect=Rectangle(width =5.0 ,height=3.0);
    area =print("Area:",rect.area());
    perimeter =print("Perimeter:",rect.perimeter());
}
    









# Manual : Simple Rectangle Calculator
# def calculate_area(width: float, height: float) -> float {
#     return width * height;
# }

# def calculate_perimeter(width: float, height: float) -> float {
#     return 2 * (width + height);
# }

# def describe_rectangle(width: float, height: float) {
#     area = calculate_area(width, height);
#     perimeter = calculate_perimeter(width, height);

#     print(f"Rectangle: {width} x {height}");
#     print(f"Area: {area}");
#     print(f"Perimeter: {perimeter}");
# }

# with entry {
#     describe_rectangle(5.0, 3.0);
# }