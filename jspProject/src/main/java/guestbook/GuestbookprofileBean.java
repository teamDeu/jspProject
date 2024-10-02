package guestbook;

public class GuestbookprofileBean {
    private String userId;
    private String profileName;
    private String profilePicture;
    private String profileBirth;
    private String profileHobby;
    private String profileEmail;
    private String profileMbti;
    private String profileContent;
    public String getProfileBirth() {
		return profileBirth;
	}

	public void setProfileBirth(String profileBirth) {
		this.profileBirth = profileBirth;
	}

	public String getProfileHobby() {
		return profileHobby;
	}

	public void setProfileHobby(String profileHobby) {
		this.profileHobby = profileHobby;
	}

	public String getProfileEmail() {
		return profileEmail;
	}

	public void setProfileEmail(String profileEmail) {
		this.profileEmail = profileEmail;
	}

	public String getProfileMbti() {
		return profileMbti;
	}

	public void setProfileMbti(String profileMbti) {
		this.profileMbti = profileMbti;
	}

	public String getProfileContent() {
		return profileContent;
	}

	public void setProfileContent(String profileContent) {
		this.profileContent = profileContent;
	}

	// Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getProfileName() {
        return profileName;
    }

    public void setProfileName(String profileName) {
        this.profileName = profileName;
    }

    // Getter and Setter for profilePicture
    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }
}
