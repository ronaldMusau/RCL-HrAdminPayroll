/// <summary>
/// Enum Rating Scale — 4-point Impact model per BRD Phase 1.
/// </summary>
enum 52211626 "Rating Scale"
{
    Extensible = true;

    value(0; "")
    {
        Caption = '';
    }
    value(1; "Developing Impact")
    {
        Caption = 'Developing Impact (0%-60%)';
    }
    value(2; "Expected Impact")
    {
        Caption = 'Expected Impact (61%-99%)';
    }
    value(3; "Significant Impact")
    {
        Caption = 'Significant Impact (100%-120%)';
    }
    value(4; "Transformational Impact")
    {
        Caption = 'Transformational Impact (121%+)';
    }
}
