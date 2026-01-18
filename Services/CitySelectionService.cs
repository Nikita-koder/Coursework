namespace Lab5_Identity.Services;

public class CitySelectionService
{
    private string? _selectedCity;

    public event Action? OnCityChanged;

    public string? SelectedCity
    {
        get => _selectedCity;
        set
        {
            if (_selectedCity != value)
            {
                _selectedCity = value;
                OnCityChanged?.Invoke();
            }
        }
    }

    public async Task<string?> GetSelectedCityAsync()
    {
        return await Task.FromResult(_selectedCity);
    }

    public async Task SetSelectedCityAsync(string? city)
    {
        SelectedCity = city;
        await Task.CompletedTask;
    }
}
