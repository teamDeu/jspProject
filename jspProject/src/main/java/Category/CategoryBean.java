package Category;

public class CategoryBean {
    private String userId;
    private String categoryType;
    private String categoryName;
    private int categorySecret;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getCategorySecret() {
        return categorySecret;
    }

    public void setCategorySecret(int categorySecret) {
        this.categorySecret = categorySecret;
    }
}

